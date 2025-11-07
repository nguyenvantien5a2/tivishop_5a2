// New SearchServlet.java for handling search
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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        ProductDAO dao = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        List<Product> products = dao.getProductsByName(query);
        for (Product p : products) {
            List<Review> reviews = reviewDAO.getReviewsByProductId(p.getId());
            double avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(0.0);
            p.setAverageRating(avgRating);
            p.setReviewCount(reviews.size());
        }
        req.setAttribute("products", products);
        req.setAttribute("brands", dao.getAllBrands());
        req.getRequestDispatcher("/products.jsp").forward(req, resp);
    }
}