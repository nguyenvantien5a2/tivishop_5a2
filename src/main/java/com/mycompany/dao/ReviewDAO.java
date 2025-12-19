package com.mycompany.dao;

import com.mycompany.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private static final String URL = "jdbc:postgresql://localhost:5433/TiviShopDB";
    private static final String USER = "postgres";
    private static final String PASS = "123456";

    // Thêm đánh giá mới (đã sửa: kiểm tra trùng trước khi insert)
    public boolean addReview(Review review) {
        // Kiểm tra đã đánh giá chưa
        if (hasUserReviewedProduct(review.getUserId(), review.getProductId())) {
            return false; // Đã đánh giá rồi
        }

        String sql = "INSERT INTO \"Review\" (product_id, user_id, rating, comment, created_date) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, review.getProductId());
                ps.setInt(2, review.getUserId());
                ps.setInt(3, review.getRating());
                ps.setString(4, review.getComment());
                ps.setTimestamp(5, new Timestamp(review.getCreatedDate().getTime()));
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    // Lấy danh sách đánh giá theo sản phẩm
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String sql = """
            SELECT r.id, r.product_id, r.user_id, r.rating, r.comment, r.created_date, u.username
            FROM "Review" r
            JOIN "User" u ON r.user_id = u.id
            WHERE r.product_id = ?
            ORDER BY r.created_date DESC
            """;
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, productId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Review review = new Review();
                        review.setId(rs.getInt("id"));
                        review.setProductId(rs.getInt("product_id"));
                        review.setUserId(rs.getInt("user_id"));
                        review.setRating(rs.getInt("rating"));
                        review.setComment(rs.getString("comment"));
                        review.setCreatedDate(rs.getTimestamp("created_date"));
                        review.setUsername(rs.getString("username"));
                        reviews.add(review);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return reviews;
    }

    // MỚI THÊM: Kiểm tra user đã đánh giá sản phẩm này chưa
    public boolean hasUserReviewedProduct(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM \"Review\" WHERE user_id = ? AND product_id = ?";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return false;
    }
}