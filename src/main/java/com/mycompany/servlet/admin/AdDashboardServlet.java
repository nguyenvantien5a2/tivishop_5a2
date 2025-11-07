package com.mycompany.servlet.admin;

import com.mycompany.dao.OrderDAO;
import com.mycompany.dao.ProductDAO;
import com.mycompany.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();
        int productCount = productDAO.getAllProducts().size();
        List<Order> orders = orderDAO.getAllOrders();
        double totalRevenue = orders.stream().mapToDouble(Order::getTotalAmount).sum();
        req.setAttribute("productCount", productCount);
        req.setAttribute("orderCount", orders.size());
        req.setAttribute("totalRevenue", totalRevenue);
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}