package com.mycompany.servlet;

import com.mycompany.dao.ProductDAO;
import com.mycompany.model.CartItem;
import com.mycompany.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(productId);
            if (product != null && product.getQuantity() > 0) {
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        if (item.getQuantity() + 1 <= product.getQuantity()) {
                            item.setQuantity(item.getQuantity() + 1);
                        }
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItem(product, 1));
                }
            } else {
                resp.sendRedirect("cart?error=Sản phẩm không có sẵn hoặc đã hết hàng");
                return;
            }
        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int newQuantity = Integer.parseInt(req.getParameter("quantity"));
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    if (newQuantity > 0 && newQuantity <= item.getProduct().getQuantity()) {
                        item.setQuantity(newQuantity);
                    } else if (newQuantity <= 0) {
                        cart.remove(item);
                    } else {
                        resp.sendRedirect("cart?error=Số lượng vượt quá tồn kho");
                        return;
                    }
                    break;
                }
            }
        } else if ("increase".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId && item.getQuantity() < item.getProduct().getQuantity()) {
                    item.setQuantity(item.getQuantity() + 1);
                    break;
                }
            }
        } else if ("decrease".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {
                        cart.remove(item);
                    }
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("cart");
    }
}