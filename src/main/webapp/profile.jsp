<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f6f8; }
        .profile-container { background: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); max-width: 600px; margin: 20px auto 0px auto;}
        .btn-update { background: #007bff; color: white; border: none; }
    </style>
</head>
<body>
<!--a-->
    <div class="container profile-container"> 
        <h1 class="text-center mb-4" style="color: #007bff;"><i class="fa-solid fa-pen-to-square"></i> Profile</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success text-center">${success}</div>
        </c:if>
        <form action="profile" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và Tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="${currentUser.fullName}" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${currentUser.email}" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Số Điện Thoại</label>
                <input type="tel" class="form-control" id="phone" name="phone" value="${currentUser.phone}">
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Địa Chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="${currentUser.address}">
            </div>
            <div class="mb-3">
                <label for="newPassword" class="form-label">Mật Khẩu Mới (nếu muốn đổi)</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword">
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Xác Nhận Mật Khẩu Mới</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
            </div>
            <button type="submit" class="btn btn-update w-100">Cập Nhật</button>
        </form>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>