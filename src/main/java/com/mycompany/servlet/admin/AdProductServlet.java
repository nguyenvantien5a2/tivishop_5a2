package com.mycompany.servlet.admin;

import com.mycompany.dao.ProductDAO;
import com.mycompany.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/productss")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AdProductServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "images";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TiviShopDB;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    private static final String USER = "sa";
    private static final String PASS = "123456";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = dao.getProductById(id);
                if (product != null) {
                    req.setAttribute("product", product);
                } else {
                    req.setAttribute("error", "Không tìm thấy sản phẩm với ID: " + id);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID sản phẩm không hợp lệ!");
            }
        }
        req.setAttribute("products", dao.getAllProducts());
        req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if ("add".equals(action) || "update".equals(action)) {
            Product product = new Product();
            if ("update".equals(action)) {
                try {
                    product.setId(Integer.parseInt(req.getParameter("id")));
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "ID sản phẩm không hợp lệ!");
                    req.setAttribute("products", dao.getAllProducts());
                    req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                    return;
                }
            }
            product.setName(req.getParameter("name"));
            try {
                product.setPrice(Double.parseDouble(req.getParameter("price")));
                product.setOriginalPrice(Double.parseDouble(req.getParameter("originalPrice")));
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Giá sản phẩm hoặc giá gốc không hợp lệ!");
                req.setAttribute("products", dao.getAllProducts());
                req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                return;
            }
            product.setDescription(req.getParameter("description"));
            try {
                product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Số lượng tồn kho không hợp lệ!");
                req.setAttribute("products", dao.getAllProducts());
                req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                return;
            }
            product.setBrand(req.getParameter("brand"));

            // Xử lý ảnh chính
            Part imagePart = req.getPart("image");
            String imageName = "";
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = imagePart.getSubmittedFileName();
                if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".jpeg") && !fileName.toLowerCase().endsWith(".png")) {
                    req.setAttribute("error", "Chỉ hỗ trợ tệp JPG hoặc PNG cho ảnh chính!");
                    req.setAttribute("products", dao.getAllProducts());
                    req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                    return;
                }
                imageName = UUID.randomUUID().toString() + "_" + fileName;
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                imagePart.write(uploadPath + File.separator + imageName);
                // Xóa ảnh cũ nếu cập nhật
                if ("update".equals(action)) {
                    Product existingProduct = dao.getProductById(product.getId());
                    String oldImage = existingProduct.getImage();
                    if (oldImage != null && !oldImage.isEmpty()) {
                        File oldFile = new File(uploadPath + File.separator + oldImage);
                        if (oldFile.exists()) oldFile.delete();
                    }
                }
            } else if ("update".equals(action)) {
                Product existingProduct = dao.getProductById(product.getId());
                imageName = existingProduct.getImage();
            } else {
                req.setAttribute("error", "Vui lòng tải lên ảnh chính!");
                req.setAttribute("products", dao.getAllProducts());
                req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                return;
            }
            product.setImage(imageName);

            // Xử lý danh sách ảnh phụ
            List<String> imageNames = new ArrayList<>();
            for (Part part : req.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".jpeg") && !fileName.toLowerCase().endsWith(".png")) {
                        req.setAttribute("error", "Chỉ hỗ trợ tệp JPG hoặc PNG cho ảnh phụ!");
                        req.setAttribute("products", dao.getAllProducts());
                        req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                        return;
                    }
                    String newFileName = UUID.randomUUID().toString() + "_" + fileName;
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    part.write(uploadPath + File.separator + newFileName);
                    imageNames.add(newFileName);
                }
            }
            if ("update".equals(action) && imageNames.isEmpty()) {
                Product existingProduct = dao.getProductById(product.getId());
                imageNames = existingProduct.getImages();
            }
            product.setImages(imageNames);

            // Thêm hoặc cập nhật sản phẩm
            boolean success = "add".equals(action) ? dao.addProduct(product) : dao.updateProduct(product);
            if (success) {
                System.out.println("Product " + ("add".equals(action) ? "added" : "updated") + " successfully: " + product.getName());
            } else {
                req.setAttribute("error", "Lỗi khi " + ("add".equals(action) ? "thêm" : "cập nhật") + " sản phẩm!");
                req.setAttribute("products", dao.getAllProducts());
                req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                return;
            }
        } else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product existingProduct = dao.getProductById(id);
                if (isProductInUse(id)) {
                    req.setAttribute("error", "Không thể xóa sản phẩm vì đã được sử dụng trong đơn hàng hoặc đánh giá!");
                    req.setAttribute("products", dao.getAllProducts());
                    req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                    return;
                }
                if (dao.deleteProduct(id)) {
                    // Xóa ảnh khi xóa sản phẩm
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    String oldImage = existingProduct.getImage();
                    if (oldImage != null && !oldImage.isEmpty()) {
                        File oldFile = new File(uploadPath + File.separator + oldImage);
                        if (oldFile.exists()) oldFile.delete();
                    }
                    for (String img : existingProduct.getImages()) {
                        File oldFile = new File(uploadPath + File.separator + img);
                        if (oldFile.exists()) oldFile.delete();
                    }
                    System.out.println("Product deleted successfully: ID " + id);
                } else {
                    req.setAttribute("error", "Lỗi khi xóa sản phẩm!");
                    req.setAttribute("products", dao.getAllProducts());
                    req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID sản phẩm không hợp lệ!");
                req.setAttribute("products", dao.getAllProducts());
                req.getRequestDispatcher("/admin/manage-products.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/productss");
    }

    private boolean isProductInUse(int productId) {
        String sql = "SELECT COUNT(*) FROM OrderDetail WHERE product_id = ? UNION SELECT COUNT(*) FROM Review WHERE product_id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (rs.getInt(1) > 0) {
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}