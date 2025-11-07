package com.mycompany.servlet.admin;

import com.mycompany.dao.UserDAO;
import com.mycompany.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/userss")
public class AdUserServlet extends HttpServlet {
    private UserDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("Action received: " + action); // Debug
        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                User user = dao.getUserById(id);
                if (user != null) {
                    req.setAttribute("user", user);
                    System.out.println("Editing user: " + user.getUsername());
                } else {
                    req.setAttribute("error", "Không tìm thấy người dùng với ID: " + id);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID người dùng không hợp lệ!");
            }
        }
        req.setAttribute("users", dao.getAllUsers());
        req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("POST action: " + action); // Debug

        if ("add".equals(action)) {
            User user = new User();
            user.setUsername(req.getParameter("username"));
            user.setPassword(req.getParameter("password"));
            user.setEmail(req.getParameter("email"));
            user.setFullName(req.getParameter("fullName"));
            user.setRole(req.getParameter("role"));
            if (dao.isUsernameOrEmailExists(user.getUsername(), user.getEmail())) {
                req.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại!");
                req.setAttribute("users", dao.getAllUsers());
                req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                return;
            }
            if (dao.addUser(user)) {
                System.out.println("User added successfully: " + user.getUsername());
            } else {
                req.setAttribute("error", "Lỗi khi thêm người dùng!");
                req.setAttribute("users", dao.getAllUsers());
                req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                return;
            }
        } else if ("update".equals(action)) {
            User user = new User();
            try {
                user.setId(Integer.parseInt(req.getParameter("id")));
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID người dùng không hợp lệ!");
                req.setAttribute("users", dao.getAllUsers());
                req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                return;
            }
            user.setUsername(req.getParameter("username"));
            user.setEmail(req.getParameter("email"));
            user.setFullName(req.getParameter("fullName"));
            user.setRole(req.getParameter("role"));
            String password = req.getParameter("password");
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            } else {
                User existingUser = dao.getUserById(user.getId());
                if (existingUser != null) {
                    user.setPassword(existingUser.getPassword());
                } else {
                    req.setAttribute("error", "Không tìm thấy người dùng để cập nhật!");
                    req.setAttribute("users", dao.getAllUsers());
                    req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                    return;
                }
            }
            if (dao.updateUser(user)) {
                System.out.println("User updated successfully: " + user.getUsername());
            } else {
                req.setAttribute("error", "Lỗi khi cập nhật người dùng!");
                req.setAttribute("users", dao.getAllUsers());
                req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                return;
            }
            } else if ("delete".equals(action)) {
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    boolean deleted = dao.deleteUser(id); // Gọi DAO để xóa user
                    if (deleted) {
                        System.out.println("User deleted successfully: ID " + id);
                    } else {
                        req.setAttribute("error", "Lỗi khi xóa người dùng! Có thể người dùng có dữ liệu liên quan (đơn hàng, v.v.).");
                        req.setAttribute("users", dao.getAllUsers());
                        req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "ID người dùng không hợp lệ!");
                    req.setAttribute("users", dao.getAllUsers());
                    req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                    return;
                } catch (Exception e) {
                    // Đảm bảo rằng lỗi bất kỳ đều được hiển thị chính xác
                    req.setAttribute("error", "Lỗi bất ngờ khi xóa người dùng: " + e.getMessage());
                    req.setAttribute("users", dao.getAllUsers());
                    req.getRequestDispatcher("/admin/manage-users.jsp").forward(req, resp);
                    return;
                }
            }
        resp.sendRedirect(req.getContextPath() + "/admin/userss");
    }
}
