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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        String sort = req.getParameter("sort");
        ProductDAO dao = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        List<Product> products = dao.getProducts(brand, sort); // Assuming getProducts handles null brand/sort
        for (Product p : products) {
            List<Review> reviews = reviewDAO.getReviewsByProductId(p.getId());
            double avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(0.0);
            p.setAverageRating(avgRating);
            p.setReviewCount(reviews.size());
        }
        req.setAttribute("products", products);
        req.setAttribute("brands", dao.getAllBrands());
        req.setAttribute("selectedBrand", brand);
        req.setAttribute("selectedSort", sort);
        req.getRequestDispatcher("/products.jsp").forward(req, resp); // Ensure correct JSP
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Reuse doGet for simplicity
    }
}