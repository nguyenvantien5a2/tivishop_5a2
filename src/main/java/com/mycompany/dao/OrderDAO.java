package com.mycompany.dao;

import com.mycompany.model.CartItem;
import com.mycompany.model.Order;
import com.mycompany.model.OrderDetail;
import com.mycompany.model.Payment;
import com.mycompany.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {
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

    // Tạo đơn hàng mới và trả về ID
    public int createOrder(Order order) {
        String sql = "INSERT INTO \"Order\" (user_id, total_amount, status, created_date, address, billing_name, billing_phone, billing_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUserId());
                ps.setDouble(2, order.getTotalAmount());
                ps.setString(3, order.getStatus());
                ps.setTimestamp(4, new Timestamp(order.getCreatedDate().getTime()));
                ps.setString(5, order.getAddress());
                ps.setString(6, order.getBillingName());
                ps.setString(7, order.getBillingPhone());
                ps.setString(8, order.getBillingEmail());
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int orderId = generatedKeys.getInt(1);
                            conn.commit();
                            return orderId;
                        }
                    }
                }
                conn.rollback();
                return -1;
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return -1;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Thêm chi tiết đơn hàng
    public boolean addOrderDetails(int orderId, List<CartItem> cartItems) {
        String sql = "INSERT INTO \"OrderDetail\" (order_id, product_id, quantity) VALUES (?, ?, ?)";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (CartItem item : cartItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getProduct().getId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();
                }
                int[] rowsAffected = ps.executeBatch();
                for (int row : rowsAffected) {
                    if (row <= 0) {
                        conn.rollback();
                        return false;
                    }
                }
                conn.commit();
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Tạo thanh toán (Payment)
    public boolean createPayment(Payment payment) {
        String sql = "INSERT INTO \"Payment\" (order_id, amount, transaction_id, status) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, payment.getOrderId());
                ps.setDouble(2, payment.getAmount());
                ps.setString(3, payment.getTransactionId());
                ps.setString(4, payment.getStatus());
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    return true;
                }
                conn.rollback();
                return false;
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Cập nhật tồn kho sản phẩm
    public boolean updateProductQuantities(List<CartItem> cartItems) {
        String sql = "UPDATE \"Product\" SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (CartItem item : cartItems) {
                    ps.setInt(1, item.getQuantity());
                    ps.setInt(2, item.getProduct().getId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();
                }
                int[] rowsAffected = ps.executeBatch();
                for (int row : rowsAffected) {
                    if (row <= 0) {
                        conn.rollback();
                        return false;
                    }
                }
                conn.commit();
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Lấy tất cả đơn hàng của user
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM \"Order\" WHERE user_id = ? ORDER BY created_date DESC";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Order order = new Order();
                        order.setId(rs.getInt("id"));
                        order.setUserId(rs.getInt("user_id"));
                        order.setTotalAmount(rs.getDouble("total_amount"));
                        order.setStatus(rs.getString("status"));
                        order.setCreatedDate(rs.getTimestamp("created_date"));
                        order.setAddress(rs.getString("address"));
                        order.setBillingName(rs.getString("billing_name"));
                        order.setBillingPhone(rs.getString("billing_phone"));
                        order.setBillingEmail(rs.getString("billing_email"));
                        orders.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Lấy đơn hàng theo ID
    public Order getOrderById(int id) {
        Order order = null;
        String sql = "SELECT * FROM \"Order\" WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        order = new Order();
                        order.setId(rs.getInt("id"));
                        order.setUserId(rs.getInt("user_id"));
                        order.setTotalAmount(rs.getDouble("total_amount"));
                        order.setStatus(rs.getString("status"));
                        order.setCreatedDate(rs.getTimestamp("created_date"));
                        order.setAddress(rs.getString("address"));
                        order.setBillingName(rs.getString("billing_name"));
                        order.setBillingPhone(rs.getString("billing_phone"));
                        order.setBillingEmail(rs.getString("billing_email"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // Lấy chi tiết đơn hàng theo orderId
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.id, od.order_id, od.product_id, od.quantity, p.name, p.price, p.image " +
                     "FROM \"OrderDetail\" od JOIN \"Product\" p ON od.product_id = p.id " +
                     "WHERE od.order_id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        OrderDetail detail = new OrderDetail();
                        detail.setId(rs.getInt("id"));
                        detail.setOrderId(rs.getInt("order_id"));
                        detail.setProductId(rs.getInt("product_id"));
                        detail.setQuantity(rs.getInt("quantity"));

                        Product product = new Product();
                        product.setId(rs.getInt("product_id"));
                        product.setName(rs.getString("name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setImage(rs.getString("image"));
                        detail.setProduct(product);

                        details.add(detail);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM \"Order\" ORDER BY created_date DESC";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedDate(rs.getTimestamp("created_date"));
                    order.setAddress(rs.getString("address"));
                    order.setBillingName(rs.getString("billing_name"));
                    order.setBillingPhone(rs.getString("billing_phone"));
                    order.setBillingEmail(rs.getString("billing_email"));
                    orders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE \"Order\" SET status = ? WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, orderId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa đơn hàng
    public boolean deleteOrder(int orderId) {
        String deleteOrderDetailsSql = "DELETE FROM \"OrderDetail\" WHERE order_id = ?";
        String deletePaymentSql = "DELETE FROM \"Payment\" WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM \"Order\" WHERE id = ?";
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            conn.setAutoCommit(false);

            // Xóa OrderDetails
            try (PreparedStatement ps = conn.prepareStatement(deleteOrderDetailsSql)) {
                ps.setInt(1, orderId);
                ps.executeUpdate();
            }

            // Xóa Payment
            try (PreparedStatement ps = conn.prepareStatement(deletePaymentSql)) {
                ps.setInt(1, orderId);
                ps.executeUpdate();
            }

            // Xóa Order
            try (PreparedStatement ps = conn.prepareStatement(deleteOrderSql)) {
                ps.setInt(1, orderId);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Lấy đơn hàng kèm chi tiết sản phẩm theo orderId
    public Order getOrderDetails(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM \"Order\" WHERE id = ?";
        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        order = new Order();
                        order.setId(rs.getInt("id"));
                        order.setUserId(rs.getInt("user_id"));
                        order.setTotalAmount(rs.getDouble("total_amount"));
                        order.setStatus(rs.getString("status"));
                        order.setCreatedDate(rs.getTimestamp("created_date"));
                        order.setAddress(rs.getString("address"));
                        order.setBillingName(rs.getString("billing_name"));
                        order.setBillingPhone(rs.getString("billing_phone"));
                        order.setBillingEmail(rs.getString("billing_email"));

                        // Lấy chi tiết đơn hàng
                        List<OrderDetail> details = getOrderDetailsByOrderId(orderId);
                        order.setOrderDetails(details);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }
}