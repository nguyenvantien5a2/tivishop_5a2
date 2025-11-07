package com.mycompany.servlet.admin;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orderss")
public class AdOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        String action = req.getParameter("action");
        System.out.println("Action received: " + action); // Debug

        // Lấy danh sách tất cả đơn hàng
        List<Order> orders = orderDAO.getAllOrders();
        req.setAttribute("orders", orders);

        // Xử lý hành động xem chi tiết
        if ("view".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            Order order = orderDAO.getOrderDetails(orderId);
            req.setAttribute("viewOrder", order);
            System.out.println("Viewing order: " + order); // Debug
        }

        req.getRequestDispatcher("/admin/manage-orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("POST action: " + action); // Debug
        OrderDAO orderDAO = new OrderDAO();
        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");
            orderDAO.updateOrderStatus(orderId, status);
            req.getSession().setAttribute("success", "Cập nhật trạng thái thành công!");
        } else if ("delete".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            boolean deleted = orderDAO.deleteOrder(orderId);
            if (deleted) {
                req.getSession().setAttribute("success", "Xóa đơn hàng thành công!");
            } else {
                req.getSession().setAttribute("error", "Xóa đơn hàng thất bại!");
            }
        }
        resp.sendRedirect("orderss");
    }
}