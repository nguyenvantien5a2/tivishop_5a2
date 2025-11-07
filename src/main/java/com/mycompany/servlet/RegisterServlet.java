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
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");

        // === VALIDATION MẬT KHẨU ===
        String passwordError = validatePassword(password);
        if (passwordError != null) {
            req.setAttribute("error", passwordError);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        UserDAO userDAO = new UserDAO();
        if (userDAO.isUsernameOrEmailExists(username, email)) {
            req.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại!");
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setRole("USER");

        if (userDAO.addUser(user)) {
            req.setAttribute("success", "Bạn đã đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }

    // === Hàm kiểm tra mật khẩu ===
    private String validatePassword(String password) {
        if (password == null || password.length() < 8) {
            return "Mật khẩu phải có ít nhất 8 ký tự.";
        }
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?].*")) {
            return "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt.";
        }
        return null; // hợp lệ
    }
}