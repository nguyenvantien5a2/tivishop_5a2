package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.CartItem;
import com.mycompany.model.Order;
import com.mycompany.model.Payment;
import com.mycompany.model.PendingOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

@WebServlet("/momo-confirm")
public class MomoConfirmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        PendingOrder pendingOrder = (PendingOrder) session.getAttribute("pendingOrder");

        if (pendingOrder == null) {
            resp.sendRedirect("checkout");
            return;
        }

        List<CartItem> cart = pendingOrder.getCartItems();
        OrderDAO orderDAO = new OrderDAO();

        try {
            if (!orderDAO.updateProductQuantities(cart)) {
                throw new SQLException("Một số sản phẩm không đủ tồn kho!");
            }

            Order order = new Order();
            order.setUserId(pendingOrder.getUserId());
            order.setTotalAmount(pendingOrder.getTotalAmount());
            order.setStatus("CONFIRMED"); // MoMo thanh toán ngay
            order.setCreatedDate(pendingOrder.getCreatedDate());
            order.setAddress(pendingOrder.getAddress());
            order.setBillingName(pendingOrder.getBillingName());
            order.setBillingPhone(pendingOrder.getBillingPhone());
            order.setBillingEmail(pendingOrder.getBillingEmail());

            int orderId = orderDAO.createOrder(order);
            if (orderId == -1) {
                throw new SQLException("Tạo đơn hàng thất bại!");
            }

            if (!orderDAO.addOrderDetails(orderId, cart)) {
                throw new SQLException("Thêm chi tiết đơn hàng thất bại!");
            }

            String transactionId = "MOMO-TX-" + String.format("%08d", new Random().nextInt(100000000));
            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(pendingOrder.getTotalAmount());
            payment.setTransactionId(transactionId);
            payment.setStatus("SUCCESS");

            if (!orderDAO.createPayment(payment)) {
                throw new SQLException("Tạo thanh toán thất bại!");
            }

            Order confirmedOrder = orderDAO.getOrderDetails(orderId);

            session.removeAttribute("cart");
            session.removeAttribute("pendingOrder");

            req.setAttribute("order", confirmedOrder);
            req.getRequestDispatcher("/momo-confirmation.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/momo-preview.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/momo-preview.jsp").forward(req, resp);
        }
    }
}