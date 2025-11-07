package com.mycompany.servlet;

import com.mycompany.dao.UserDAO;
import com.mycompany.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password"); // In production, hash this
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String role = req.getParameter("role");

        UserDAO userDAO = new UserDAO();
        if (userDAO.isUsernameOrEmailExists(username, email)) {
            req.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Hash password in production
        user.setEmail(email);
        user.setFullName(fullName);
        user.setRole(role != null ? role : "USER");

        if (userDAO.addUser(user)) {
            resp.sendRedirect("login");
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}