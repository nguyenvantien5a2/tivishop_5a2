# 🖥️ Ứng dung ngôn ngữ Java xây dựng website bán tivi theo mô hình MVC

## 🎯 Giới thiệu
Đề tài xây dựng **website bán tivi trực tuyến** bằng ngôn ngữ **Java**, áp dụng mô hình **MVC (Model – View – Controller)** nhằm tổ chức mã nguồn rõ ràng, tách biệt giữa giao diện, xử lý và dữ liệu.

Mục tiêu chính:
- Áp dụng kỹ thuật **JSP/Servlet** trong lập trình web.
- Tạo hệ thống **bán hàng – quản lý sản phẩm – người dùng – đơn hàng**.
- Phân quyền giữa **User** và **Admin**.
- Triển khai web thực tế trên **Render Cloud** sử dụng **Docker** và **PostgreSQL**.

---

## ⚙️ Kiến trúc hệ thống (MVC)

### 🧩 Model
- Các lớp Java (Entity, DAO) quản lý dữ liệu và kết nối với cơ sở dữ liệu PostgreSQL qua JDBC.  
- Xử lý các thao tác CRUD cho sản phẩm, người dùng, đơn hàng, đánh giá,...

### 🖥️ View
- Giao diện động sử dụng **JSP**, **HTML**, **CSS**, **Bootstrap**, **Font Awesome**, **JavaScript**.  
- Hiển thị sản phẩm, biểu mẫu đăng nhập, đăng ký, giỏ hàng, đơn hàng, dashboard, v.v.  
- Gửi request về Controller thông qua form hoặc link.

### 🧠 Controller
- Các lớp **Servlet** xử lý request, gọi Model, nhận dữ liệu và trả về View tương ứng.  
- Quản lý session người dùng, xác thực đăng nhập và phân quyền theo vai trò.

---

## 🛒 Chức năng hệ thống

### 👤 Người dùng (User)
- Đăng ký, đăng nhập, đăng xuất tài khoản.
- Xem danh sách sản phẩm, lọc theo thương hiệu (Sony, Samsung, LG...) và khoảng giá.
- Thêm sản phẩm vào giỏ hàng, cập nhật số lượng, xóa sản phẩm trong giỏ.
- Điền thông tin đặt hàng, chọn phương thức thanh toán (COD hoặc MOMO – giả lập).
- Sau khi thanh toán thành công:
  - Giảm số lượng tồn kho tương ứng.
  - Xóa giỏ hàng và session.
  - Hiển thị thông tin đơn hàng, mã đơn, khách hàng, địa chỉ.
- Quản lý tài khoản cá nhân (đổi mật khẩu, cập nhật thông tin).
- Đánh giá sản phẩm sau khi mua.

### 🧑‍💼 Quản trị viên (Admin)
- Đăng nhập tài khoản quản trị.
- **Dashboard:** hiển thị số lượng sản phẩm, đơn hàng, doanh thu tổng.
- **Quản lý sản phẩm:** thêm, sửa, xóa, xem chi tiết sản phẩm.
- **Quản lý đơn hàng:** xem, cập nhật trạng thái đơn (Pending, Confirmed, Cancelled), xóa đơn hàng.
- **Quản lý người dùng:** thêm, sửa, xóa tài khoản người dùng.

---

## 💻 Công nghệ sử dụng

| Thành phần | Công nghệ |
|-------------|------------|
| Ngôn ngữ chính | Java (Servlet, JSP) |
| Mô hình kiến trúc | MVC |
| Cơ sở dữ liệu | PostgreSQL |
| Kết nối DB | JDBC |
| Giao diện | HTML, CSS, Bootstrap, JS, Font Awesome |
| Máy chủ | Apache Tomcat |
| Công cụ build | Maven |
| Quản lý DB | pgAdmin |
| Nền tảng triển khai | Render Cloud |
| Docker | Build image và đóng gói WAR |

---

## 🚀 Triển khai & Cài đặt

### 1. Chuẩn bị môi trường
- Cài đặt **JDK (Java Development Kit)**, **Apache Tomcat**, **PostgreSQL** và **pgAdmin**.  
- Cài **Maven** để build dự án.  
- Tạo tài khoản **Render.com** để deploy web và database.

### 2. Cấu hình cơ sở dữ liệu
- Tạo database `tivishop` trong PostgreSQL:
  ```sql
  CREATE DATABASE tivishop;
  
### 3. Build & Run trên máy local

### 4. Đóng gói và triển khai Docker
- Tạo file Dockerfile trong thư mục gốc dự án:
```sql
FROM tomcat:10.1
COPY target/TiviShop.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

### 5. Triển khai lên Render
- Tạo PostgreSQL trên Render
- Tạo Web Service trên Render, cấu hình biến môi trường (DB_URL, DB_USER, DB_PASS)
- Triển khai kết nối vs PostgreSQL trên Render thông qua pgAdmin: 
    - tạo Servers (nhập hostname, port, database, username, pass…)
    - tạo query tool (chạy câu lệnh sql)
- Triển khai thành công web lên Render.
Web chạy ổn định tại: https://tivishop2.onrender.com (Mất 2 -> 3 phút để đánh thức server)

