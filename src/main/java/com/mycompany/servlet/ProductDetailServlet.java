package com.mycompany.servlet;

import com.mycompany.dao.ProductDAO;
import com.mycompany.dao.ReviewDAO;
import com.mycompany.model.Product;
import com.mycompany.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        Product product = productDAO.getProductById(productId);
        List<Review> reviews = reviewDAO.getReviewsByProductId(productId);

        // Calculate average rating and review count
        double avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(0.0);
        product.setAverageRating(avgRating);
        product.setReviewCount(reviews.size());

        req.setAttribute("product", product);
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher("/product-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle adding review
        int productId = Integer.parseInt(req.getParameter("productId"));
        int userId = Integer.parseInt(req.getParameter("userId")); // Assume user is logged in, get from session
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");
        ReviewDAO reviewDAO = new ReviewDAO();
        boolean success = reviewDAO.addReview(productId, userId, rating, comment);
        if (success) {
            resp.sendRedirect("product-detail?id=" + productId);
        } else {
            req.setAttribute("error", "Thêm đánh giá thất bại!");
            doGet(req, resp);
        }
    }
}