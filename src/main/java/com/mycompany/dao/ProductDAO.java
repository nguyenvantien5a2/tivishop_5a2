package com.mycompany.dao;

import com.mycompany.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProductDAO {
    // LẤY TỪ RENDER ENVIRONMENT VARIABLES
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASS = System.getenv("DB_PASS");

    // Kiểm tra nếu chưa set (tránh lỗi local)
    static {
        if (URL == null || USER == null || PASS == null) {
            throw new RuntimeException("Database environment variables (DB_URL, DB_USER, DB_PASS) are not set!");
        }
    }

    public List<Product> getProducts(String brand, String sort) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM \"Product\"";
        boolean hasWhere = false;
        if (brand != null && !brand.isEmpty()) {
            sql += " WHERE brand = ?";
            hasWhere = true;
        }
        if (sort != null) {
            sql += hasWhere ? " AND " : " WHERE ";
            if ("lowToHigh".equals(sort)) {
                sql += " ORDER BY price ASC";
            } else if ("highToLow".equals(sort)) {
                sql += " ORDER BY price DESC";
            }
        }
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                if (brand != null && !brand.isEmpty()) {
                    ps.setString(1, brand);
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getInt("id"));
                        p.setName(rs.getString("name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setOriginalPrice(rs.getDouble("original_price"));
                        p.setDescription(rs.getString("description"));
                        p.setImage(rs.getString("image"));
                        p.setQuantity(rs.getInt("quantity"));
                        p.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        p.setImages(imagesStr != null ? Arrays.asList(imagesStr.split(",")) : null);
                        products.add(p);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByName(String query) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM \"Product\" WHERE name ILIKE ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, "%" + query + "%");
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getInt("id"));
                        p.setName(rs.getString("name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setOriginalPrice(rs.getDouble("original_price"));
                        p.setDescription(rs.getString("description"));
                        p.setImage(rs.getString("image"));
                        p.setQuantity(rs.getInt("quantity"));
                        p.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        p.setImages(imagesStr != null ? Arrays.asList(imagesStr.split(",")) : null);
                        products.add(p);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT * FROM \"Product\" WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        product = new Product();
                        product.setId(rs.getInt("id"));
                        product.setName(rs.getString("name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setOriginalPrice(rs.getDouble("original_price"));
                        product.setDescription(rs.getString("description"));
                        product.setImage(rs.getString("image"));
                        product.setQuantity(rs.getInt("quantity"));
                        product.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        product.setImages(imagesStr != null ? Arrays.asList(imagesStr.split(",")) : null);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT brand FROM \"Product\"";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    brands.add(rs.getString("brand"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM \"Product\"";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setOriginalPrice(rs.getDouble("original_price"));
                    p.setDescription(rs.getString("description"));
                    p.setImage(rs.getString("image"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setBrand(rs.getString("brand"));
                    String imagesStr = rs.getString("images");
                    p.setImages(imagesStr != null ? Arrays.asList(imagesStr.split(",")) : null);
                    products.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO \"Product\" (name, price, original_price, description, image, quantity, brand, images) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, product.getName());
                ps.setDouble(2, product.getPrice());
                ps.setDouble(3, product.getOriginalPrice());
                ps.setString(4, product.getDescription());
                ps.setString(5, product.getImage());
                ps.setInt(6, product.getQuantity());
                ps.setString(7, product.getBrand());
                ps.setString(8, product.getImages() != null ? String.join(",", product.getImages()) : "");
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE \"Product\" SET name = ?, price = ?, original_price = ?, description = ?, image = ?, quantity = ?, brand = ?, images = ? WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, product.getName());
                ps.setDouble(2, product.getPrice());
                ps.setDouble(3, product.getOriginalPrice());
                ps.setString(4, product.getDescription());
                ps.setString(5, product.getImage());
                ps.setInt(6, product.getQuantity());
                ps.setString(7, product.getBrand());
                ps.setString(8, product.getImages() != null ? String.join(",", product.getImages()) : "");
                ps.setInt(9, product.getId());
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM \"Product\" WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}