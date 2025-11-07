<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Đăng Ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .register-container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 500px;
            margin: 50px auto; /* Add margin to prevent sticking */
            flex: 0 0 auto;
        }
        .register-title {
            color: #1E90FF;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 600;
            color: #333;
        }
        .form-control {
            border-radius: 10px;
        }
        .btn-register {
            background: linear-gradient(45deg, #2ecc71, #27ae60);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            width: 100%;
        }
        .btn-register:hover {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            transform: scale(1.05);
            color: #FFD700;
        }
        .error {
            color: #e74c3c;
            text-align: center;
            margin-top: 10px;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .login-link a {
            color: #1E90FF;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <main>
        <div class="register-container">
            <h2 class="register-title">Đăng Ký</h2>
            <form action="register" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Tên Đăng Nhập</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật Khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và Tên</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
<!--                <div class="mb-3">
                    <label for="role" class="form-label">Quyền Hạn</label>
                    <select class="form-select" id="role" name="role">
                        <option value="USER">Người Dùng</option>
                        <option value="ADMIN">Quản Trị Viên</option>
                    </select>
                </div>-->
                <input type="hidden" name="role" value="USER">
                
                <button type="submit" class="btn btn-register">Đăng Ký</button>
                <c:if test="${not empty error}">
                    <p class="error">${error}</p>
                </c:if>
            </form>
            <div class="login-link">
                <p>Đã có tài khoản? <a href="login">Đăng Nhập Ngay</a></p>
            </div>
        </div>
    </main>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>