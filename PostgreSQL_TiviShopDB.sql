-- XÓA TOÀN BỘ DB CŨ (nếu cần)
DROP TABLE IF EXISTS "Review" CASCADE;
DROP TABLE IF EXISTS "Payment" CASCADE;
DROP TABLE IF EXISTS "OrderDetail" CASCADE;
DROP TABLE IF EXISTS "Order" CASCADE;
DROP TABLE IF EXISTS "Product" CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;

-- 1. TẠO BẢNG – DÙNG "" ĐỂ GIỮ CHỮ HOA
CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER',
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE "Product" (  -- DÙNG "" ĐỂ GIỮ CHỮ HOA
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    original_price DECIMAL(18,2),
    description TEXT,
    image VARCHAR(255),
    images TEXT,
    quantity INT NOT NULL,
    brand VARCHAR(50)
);

CREATE TABLE "Order" (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id),
    total_amount DECIMAL(18,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_date TIMESTAMP NOT NULL,
    address VARCHAR(255),
    billing_name VARCHAR(100),
    billing_phone VARCHAR(20),
    billing_email VARCHAR(100)
);

CREATE TABLE "OrderDetail" (  -- DÙNG "" ĐỂ GIỮ CHỮ HOA
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES "Order"(id),
    product_id INT NOT NULL REFERENCES "Product"(id),
    quantity INT NOT NULL
);

CREATE TABLE "Payment" (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES "Order"(id),
    amount DECIMAL(18,2) NOT NULL,
    transaction_id VARCHAR(100),
    status VARCHAR(20) NOT NULL
);

CREATE TABLE "Review" (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES "Product"(id),
    user_id INT NOT NULL REFERENCES "User"(id),
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. INSERT DỮ LIỆU – DÙNG "" CHO TÊN BẢNG
INSERT INTO "User" (username, password, email, full_name, role, phone, address) VALUES 
    ('admin', 'admin123', 'admin@gmail.com', 'Admin User', 'ADMIN', '0123456789', 'Admin Address'),
    ('user1', 'user123', 'user1@gmail.com', 'Nguyen Van A', 'USER', '0901234567', '123 Đường Láng, Hà Nội'),
    ('user2', 'user123', 'user2@gmail.com', 'Tran Thi B', 'USER', '0912345678', '456 Lê Lợi, TP.HCM'),
    ('user3', 'user123', 'user3@gmail.com', 'Le Van C', 'USER', '0923456789', '789 Nguyễn Huệ, Đà Nẵng'),
    ('user4', 'user123', 'user4@gmail.com', 'Pham Thi D', 'USER', '0934567890', '1011 Trần Hưng Đạo, Nha Trang'),
    ('user5', 'user123', 'user5@gmail.com', 'Hoang Van E', 'USER', '0975656565', 'Phường Kim Mã, Hà Nội');

INSERT INTO "Product" (name, price, original_price, description, image, images, quantity, brand) VALUES 
    ('Smart TV Samsung QLED 4K', 11090000, 14000000, 'Vision AI 43 Inch QA43Q7FA', 'ss3.1.jpg', 'ss3.jpg,ss3.1.jpg,ss3.2.jpg,ss3.3.jpg,ss3.4.jpg', 7488, 'Samsung'),
    ('Sony Google TV 4K LED', 18990000, 23000000, 'NỀN BRAVIA 2 II K-55S25VM2', 'sn2.1.jpg', 'sn2.jpg,sn2.1.jpg,sn2.2.jpg,sn2.3.jpg', 6384, 'Sony'),
    ('Sony Google TV Mini LED', 13000000, 16000000, 'BRAVIA 5 K-55XR50', 'sn1.1.jpg', 'sn1.jpg,sn1.1.jpg,sn1.2.jpg,sn1.3.jpg', 3413, 'Sony'),
    ('Sony Google TV OLED', 49990000, 61000000, 'NỀN BRAVIA 8 II K-55XR80M2', 'sn3.1.jpg', 'sn3.jpg,sn3.1.jpg,sn3.2.jpg', 1246, 'Sony'),
    ('Google Tivi TCL QLED 4K', 11990000, 14500000, 'Màn 55 Inch 55P7K', 'tcl1.jpg', 'tcl1.jpg,tcl1.2.jpg', 6745, 'TCL'),
    ('Smart Tivi LG AI 4K', 19490000, 23500000, '65 Inch 65UA8450PSA', 'lg1.jpg', 'lg1.jpg,lg1.2.jpg', 3456, 'LG'),
    ('Smart TV Samsung OLED 4K', 45990000, 56000000, 'Vision AI 65 Inch QA65S90F', 'ss2.1.jpg', 'ss2.jpg,ss2.1.jpg,ss2.2.jpg,ss2.3.jpg', 1243, 'Samsung'),
    ('Smart Tivi Samsung QLED 4K', 14990000, 17500000, 'Vision AI 50 Inch QA50Q8F', 'hinh8ss.jpg', 'hinh8ss.jpg', 2456, 'Samsung'),
    ('Smart Tivi LG QNED AI 4K', 32890000, 48990000, '65 Inch 75QNED82ASA', 'hinh9lg.jpg', 'hinh9lg.jpg', 4743, 'LG'),
    ('Smart Tivi LG OLED AI 4K', 27890000, 35190000, '55 Inch OLED55B5PSA', 'hinh10lg.jpg', 'hinh10lg.jpg', 1353, 'LG'),
    ('Google Tivi TCL OLED 4K', 14490000, 22490000, '65 Inch 65P8K', 'hinh11tcl.jpg', 'hinh11tcl.jpg', 1241, 'TCL'),
    ('Google Tivi TCL QD-Mini LED 4K', 20490000, 23655000, '65 Inch 65P8K', 'hinh12tcl.jpg', 'hinh12tcl.jpg', 1546, 'TCL');

INSERT INTO "Order" (user_id, total_amount, status, created_date, address, billing_name, billing_phone, billing_email) VALUES 
    (2, 15050000, 'PENDING', '2025-09-22', '123 Đường Láng, Hà Nội', 'Nguyen Van A', '0901234567', 'user1@example.com'),
    (3, 20050000, 'CONFIRMED', '2025-09-22', '456 Lê Lợi, TP.HCM', 'Tran Thi B', '0912345678', 'user2@example.com');

INSERT INTO "OrderDetail" (order_id, product_id, quantity) VALUES 
    (1, 1, 1),
    (2, 2, 1);

INSERT INTO "Payment" (order_id, amount, transaction_id, status) VALUES 
    (1, 15050000, 'COD-TX-001', 'PENDING'),
    (2, 20050000, 'COD-TX-002', 'CONFIRMED');

INSERT INTO "Review" (product_id, user_id, rating, comment) VALUES 
    (1, 3, 5, 'Màn hình OLED cực kỳ sắc nét, xem phim rất đã.'),
    (2, 4, 4, 'Tivi đẹp, âm thanh ổn nhưng hơi đắt.'),
    (3, 5, 5, 'Chất lượng hình ảnh tuyệt vời, đáng tiền.'),
    (4, 6, 3, 'Giá tốt nhưng giao diện hơi khó dùng.'),
    (5, 6, 4, 'Thiết kế đẹp, phù hợp phòng ngủ.'),
    (6, 5, 5, 'Tivi thông minh, điều khiển giọng nói rất tiện.');

-- KIỂM TRA
SELECT * FROM "Product";
SELECT * FROM "Order";
SELECT * FROM "OrderDetail";
SELECT * FROM "Payment";
SELECT * FROM "Review";
SELECT * FROM "User";