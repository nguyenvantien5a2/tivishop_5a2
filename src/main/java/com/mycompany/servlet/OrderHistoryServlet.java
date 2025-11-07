package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.Order;
import com.mycompany.model.OrderDetail;
import com.mycompany.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"USER".equals(user.getRole())) {
            resp.sendRedirect("login");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());

        // Lấy chi tiết cho từng đơn hàng
        for (Order order : orders) {
            List<OrderDetail> details = orderDAO.getOrderDetailsByOrderId(order.getId());
            order.setOrderDetails(details); // Giả sử Order có field List<OrderDetail>
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/order-history.jsp").forward(req, resp);
    }
}