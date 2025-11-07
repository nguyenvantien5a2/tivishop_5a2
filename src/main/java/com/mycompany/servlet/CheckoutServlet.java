package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.CartItem;
import com.mycompany.model.Order;
import com.mycompany.model.Payment;
import com.mycompany.model.PendingOrder;
import com.mycompany.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w-_.+]*[\\w-_.]@([\\w]+[.])+[\\w]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[1-9]\\d{8,9}$");
    private static final double SHIPPING_FEE = 50000.0;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double total = 0;
        if (cart != null) {
            total = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
        }
        req.setAttribute("total", total);
        req.setAttribute("shippingFee", SHIPPING_FEE);
        req.setAttribute("totalWithShipping", total + SHIPPING_FEE);
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            req.setAttribute("error", "Giỏ hàng trống!");
            doGet(req, resp);
            return;
        }

        // Lấy thông tin từ form
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String paymentMethod = req.getParameter("paymentMethod");

        // Validate input
        if (fullName == null || phone == null || email == null || address == null || paymentMethod == null ||
            fullName.trim().isEmpty() || phone.trim().isEmpty() || email.trim().isEmpty() || address.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            doGet(req, resp);
            return;
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            req.setAttribute("error", "Email không hợp lệ!");
            doGet(req, resp);
            return;
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            req.setAttribute("error", "Số điện thoại không hợp lệ!");
            doGet(req, resp);
            return;
        }

        // Tính tổng tiền
        double subtotal = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
        double totalWithShipping = subtotal + SHIPPING_FEE;

        // Lưu thông tin vào PendingOrder
        PendingOrder pendingOrder = new PendingOrder();
        pendingOrder.setUserId(user.getId());
        pendingOrder.setTotalAmount(totalWithShipping);
        pendingOrder.setStatus("PENDING");
        pendingOrder.setCreatedDate(new Date());
        pendingOrder.setAddress(address);
        pendingOrder.setBillingName(fullName);
        pendingOrder.setBillingPhone(phone);
        pendingOrder.setBillingEmail(email);
        pendingOrder.setCartItems(cart);

        session.setAttribute("pendingOrder", pendingOrder);

        // Xử lý theo phương thức thanh toán
        if ("COD".equals(paymentMethod)) {
            resp.sendRedirect("cod-preview");
        } else if ("Momo".equals(paymentMethod)) {
            resp.sendRedirect("momo-preview"); // Redirect to MoMo preview
        } else {
            req.setAttribute("error", "Phương thức thanh toán không hợp lệ!");
            doGet(req, resp);
        }
    }
}