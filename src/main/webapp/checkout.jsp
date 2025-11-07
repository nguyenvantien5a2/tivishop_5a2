<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Xác Nhận Đơn Hàng</title>
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
            margin: 0;
        }
        .checkout-container {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            max-width: 1200px;
            margin: 20px auto;
        }
        .checkout-title {
            color: #007bff;
            font-weight: 600;
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .btn-confirm {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            margin-top: 10px;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .btn-back {
            background: linear-gradient(45deg, #28a745, #218838);
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            margin-top: 10px;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .btn-confirm:hover, .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            text-decoration: none;
            color: #FFD700;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #ced4da;
            padding: 10px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        .table th, .table td {
            vertical-align: middle;
            padding: 15px;
        }
        .table-dark {
            background: #343a40;
            color: white;
        }
        .alert-danger {
            border-radius: 10px;
            padding: 15px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .product-img {
            width: auto;
            height: 70px;
            object-fit: cover;
            margin-right: 16px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .order-summary {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            margin-top: 10px;
        }
        .order-summary img {
            flex-shrink: 0;
        }
        .order-summary .details {
            flex-grow: 1;
        }
        .order-summary .price {
            font-weight: bold;
            color: #dc3545;
            margin-left: auto;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            margin-top: 10px;
        }
        .summary-item .label {
            font-weight: 500;
        }
        .summary-item .value {
            font-weight: bold;
            color: #dc3545;
        }
        h4 {
            margin-top: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container checkout-container">
        <h1 class="checkout-title"><i class="fa-solid fa-pen-to-square me-2"></i>Thông Tin Đơn Hàng</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>
        <c:if test="${empty sessionScope.cart}">
            <div class="text-center">
                <p class="lead mb-4">Giỏ hàng trống! Vui lòng thêm sản phẩm.</p>
                <a href="products" class="btn btn-continue-shopping btn-lg"><i class="fas fa-shopping-bag"></i> Mua Sắm Ngay</a>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.cart}">
            <form action="checkout" method="post">
                <div class="row">
                    <div class="col-md-7">
                        <h4 class="mb-3"><i class="fa-solid fa-circle-info me-2"></i>Thông Tin Khách Hàng</h4>
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Họ và Tên (*)</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.user.fullName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">☎️ Số Điện Thoại (*)</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">📧 Email (*)</label>
                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">📍 Địa Chỉ Giao Hàng (*)</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="mb-4">
                            <h4 class="mb-3">Phương Thức Thanh Toán</h4>
                            <select class="form-select" name="paymentMethod" required>
                                <option value="Momo">&#x1F4B3; Chuyển Khoản MoMo (Giả lập)</option>
                                <option value="COD">&#x1F4E6; Thanh Toán Khi Nhận Hàng (COD)</option>
                            </select>
                        </div>

                    </div>
                    <div class="col-md-5">
                        <h4 class="mb-3"><i class="fa-solid fa-clipboard-list me-2"></i>Tóm Tắt Đơn Hàng</h4>
                        <div class="table-responsive">
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <div class="order-summary">
                                    <img src="images/${item.product.image}" alt="${item.product.name}" class="product-img">
                                    <div class="details">
                                        <div>${item.product.name}</div>
                                        <div>Số lượng: ${item.quantity}</div>
                                    </div>
                                    <div class="price">
                                        <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0" /> VND
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="summary-item">
                                <span class="label">Tạm tính:</span>
                                <span class="value"><fmt:formatNumber value="${total}" pattern="#,##0" /> VND</span>
                            </div>
                            <div class="summary-item">
                                <span class="label">Phí vận chuyển:</span>
                                <span class="value">50.000 VND</span>
                            </div>
                            <div class="summary-item">
                                <span class="label">Tổng cộng:</span>
                                <span class="value"><fmt:formatNumber value="${total + 50000}" pattern="#,##0" /> VND</span>
                            </div>
                            <div class="d-flex justify-content-between mt-3">
                                <a href="cart" class="btn btn-back btn-lg"><i class="fas fa-arrow-left"></i> Quay Lại Giỏ Hàng</a>
                                <button type="submit" class="btn btn-confirm btn-lg"><i class="fas fa-credit-card"></i> Tiếp Tục</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>