<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="headeradmin.jsp"%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="../css/admin-style.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-5" style="color: #007bff;"><i class="fas fa-tachometer-alt me-1"></i> Dashboard Admin</h1>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card p-4 text-center">
                    <i class="fas fa-box card-icon mb-3" style="font-size: 2rem; color: #007bff;"></i>
                    <h5>Số Sản Phẩm</h5>
                    <p class="lead">${productCount}</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card p-4 text-center">
                    <i class="fas fa-shopping-cart card-icon mb-3" style="font-size: 2rem; color: #007bff;"></i>
                    <h5>Số Đơn Hàng</h5>
                    <p class="lead">${orderCount}</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card p-4 text-center">
                    <i class="fas fa-dollar-sign card-icon mb-3" style="font-size: 2rem; color: #007bff;"></i>
                    <h5>Tổng Doanh Thu</h5>
                    <p class="lead"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0" /> VND</p>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>