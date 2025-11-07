<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Xác Nhận Đơn Hàng COD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .confirmation-container {
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            max-width: 900px;
            margin: 20px auto;
            flex-grow: 1;
        }
        .confirmation-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .confirmation-header h1 {
            color: #007bff;
            font-weight: 600;
            margin: 0;
        }
        .order-summary {
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .order-summary .summary-left ul,
        .order-summary .summary-right ul {
            list-style-type: none;
            padding-left: 0;
        }
        .order-summary ul li {
            margin: 10px 0;
        }
        .order-summary ul li::before {
            content: "•";
            color: #007bff;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }
        .order-summary .billing-info ul li {
            padding-left: 0;
        }
        .order-summary .billing-info ul li::before {
            content: none;
        }
        .product-details {
            margin-bottom: 20px;
        }
        .order-details {
            display: flex;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        .order-details .product-img {
            width: auto;
            height: 60px;
            object-fit: cover;
            margin-right: 15px;
        }
        .order-details .details {
            flex-grow: 1;
        }
        .order-details .price {
            font-weight: bold;
            color: #dc3545;
            margin-left: auto;
        }
        .btn-order-history {
            background: #28a745;
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            margin-right: 15px;
            text-decoration: none; /* Bỏ gạch chân */
        }
        .btn-order-history:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(40,167,69,0.4);
            text-decoration: none; 
            color: #FFD700;
        }
        .btn-continue-shopping {
            background: #007bff;
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            text-decoration: none; 
        }
        .btn-continue-shopping:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,123,255,0.4);
            text-decoration: none; 
            color: #FFD700;
        }
        .footer {
            margin-top: auto;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-header">
            <h1>Đơn Hàng đặt thành công!</h1>
            <h6 style="margin-top: 14px;">Đơn hàng #${order.id} đã được đặt thành công!</h6>
        </div>
        <c:if test="${empty order}">
            <div class="text-center">
                <p class="lead mb-4">Không tìm thấy đơn hàng!</p>
                <a href="products" class="btn-continue-shopping btn-lg">Mua Sắm Ngay</a>
            </div>
        </c:if>
        <c:if test="${not empty order}">
            <div class="order-summary card p-3">
                <div class="summary-left">
                    <ul>
                        <li><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm" /></li>
                        <li><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VND</li>
                        <li><strong>Trạng thái:</strong> ${order.status}</li>
                        <li><strong>Địa chỉ giao hàng:</strong> ${order.address}</li>
                    </ul>
                </div>
                <div class="summary-right">
                    <div class="billing-info">
                        <p><strong>Thông tin thanh toán:</strong></p>
                        <ul>
                            <li>Tên: ${order.billingName}</li>
                            <li>Số điện thoại: ${order.billingPhone}</li>
                            <li>Email: ${order.billingEmail}</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="product-details card p-3">
                <h5 class="mb-3">Chi tiết đơn hàng</h5>
                <c:forEach var="detail" items="${order.orderDetails}">
                    <div class="order-details">
                        <img src="images/${detail.product.image}" class="product-img" alt="${detail.product.name}" onerror="this.src='images/placeholder.jpg'">
                        <div class="details">
                            <div>${detail.product.name}</div>
                            <div>Số lượng: ${detail.quantity}</div>
                        </div>
                        <div class="price">
                            <fmt:formatNumber value="${detail.product.price * detail.quantity}" pattern="#,##0"/> VND
                        </div>
                    </div>
                </c:forEach>
                <p class="mt-3">Đơn hàng sẽ được giao trong 3-5 ngày làm việc. Vui lòng kiểm tra email để nhận cập nhật trạng thái.</p>
            </div>
            <div class="text-center mt-4">
                <a href="order-history" class="btn-order-history btn-lg"><i class="fa-solid fa-clock-rotate-left"></i> Lịch Sử Đơn Hàng</a>
                <a href="products" class="btn-continue-shopping btn-lg"><i class="fas fa-shopping-bag"></i> Tiếp Tục Mua Sắm</a>
            </div>
        </c:if>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>