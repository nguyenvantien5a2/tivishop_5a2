package com.mycompany.servlet;

import com.mycompany.dao.UserDAO;
import com.mycompany.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;

// Import BCrypt nếu dùng hash: import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w-_.+]*[\\w-_.]@([\\w]+[.])+[\\w]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[1-9]\\d{8,9}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        // Lấy user đầy đủ từ DB (nếu cần refresh)
        UserDAO dao = new UserDAO();
        User currentUser = dao.getUserById(user.getId());
        req.setAttribute("currentUser", currentUser);
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        // Lấy params từ form
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // Validate
        if (fullName == null || email == null || fullName.trim().isEmpty() || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ họ tên và email!");
            doGet(req, resp);
            return;
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            req.setAttribute("error", "Email không hợp lệ!");
            doGet(req, resp);
            return;
        }
        if (phone != null && !phone.trim().isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
            req.setAttribute("error", "Số điện thoại không hợp lệ!");
            doGet(req, resp);
            return;
        }
        if (newPassword != null && !newPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu mới không khớp!");
                doGet(req, resp);
                return;
            }
            // Hash password (nếu dùng BCrypt)
            // newPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        } else {
            newPassword = user.getPassword(); // Giữ password cũ nếu không đổi
        }

        // Cập nhật user
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setUsername(user.getUsername());
        updatedUser.setPassword(newPassword);
        updatedUser.setEmail(email);
        updatedUser.setFullName(fullName);
        updatedUser.setRole(user.getRole());
        updatedUser.setPhone(phone);
        updatedUser.setAddress(address);

        UserDAO dao = new UserDAO();
        if (dao.updateUser(updatedUser)) {
            // Cập nhật session
            session.setAttribute("user", updatedUser);
            req.setAttribute("success", "Cập nhật profile thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
        }
        doGet(req, resp);
    }
}