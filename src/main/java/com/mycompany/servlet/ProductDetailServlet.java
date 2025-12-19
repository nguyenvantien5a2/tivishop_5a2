package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.dao.ProductDAO;
import com.mycompany.dao.ReviewDAO;
import com.mycompany.model.Product;
import com.mycompany.model.Review;
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

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("id"));

        ProductDAO productDAO = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        Product product = productDAO.getProductById(productId);
        List<Review> reviews = reviewDAO.getReviewsByProductId(productId);

        // Tính trung bình đánh giá
        double avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(0.0);
        product.setAverageRating(avgRating);
        product.setReviewCount(reviews.size());

        // Kiểm tra quyền đánh giá để JSP ẩn/hiện form
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        boolean canReview = false;
        if (user != null) {
            OrderDAO orderDAO = new OrderDAO();
            canReview = orderDAO.canUserReviewProduct(user.getId(), productId)
                    && !reviewDAO.hasUserReviewedProduct(user.getId(), productId);
        }
        req.setAttribute("canReview", canReview);

        req.setAttribute("product", product);
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher("/product-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        OrderDAO orderDAO = new OrderDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        // Kiểm tra quyền đánh giá
        if (!orderDAO.canUserReviewProduct(user.getId(), productId)) {
            req.setAttribute("error", "Bạn chỉ có thể đánh giá sản phẩm sau khi đơn hàng đã được giao thành công (DELIVERED)!");
            doGet(req, resp);
            return;
        }

        // Kiểm tra đã đánh giá chưa
        if (reviewDAO.hasUserReviewedProduct(user.getId(), productId)) {
            req.setAttribute("error", "Bạn đã đánh giá sản phẩm này rồi!");
            doGet(req, resp);
            return;
        }

        // Thêm đánh giá
        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getId());
        review.setRating(rating);
        review.setComment(comment);
        review.setCreatedDate(new Date());

        if (reviewDAO.addReview(review)) {
            resp.sendRedirect("product-detail?id=" + productId);
        } else {
            req.setAttribute("error", "Thêm đánh giá thất bại! Vui lòng thử lại.");
            doGet(req, resp);
        }
    }
}