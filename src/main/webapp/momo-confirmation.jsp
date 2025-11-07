<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Xác Nhận Thanh Toán MoMo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fff2e8 0%, #ffdbac 100%);
        }
        .confirmation-container {
            background: #fff;
            padding: 50px;
            border-radius: 25px;
            box-shadow: 0 15px 50px rgba(250, 92, 0, 0.2);
            max-width: 900px;
            margin: 20px auto;
            text-align: center;
        }
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 20px;
        }
        .momo-success-header {
            background: linear-gradient(45deg, #FA5C00, #FF8C00);
            color: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
        }
        
        
        .btn-home {
            background: linear-gradient(45deg, #FA5C00, #FF8C00);
            color: white;
            border-radius: 30px;
            padding: 15px 40px;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s;
        }
        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(250, 92, 0, 0.4);
            color: white;
        }
        
        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px; 
        }

        .btn, .btn-home {
            padding: 15px 40px; 
            font-size: 1.25rem; 
            line-height: 1.5; 
        }
        
        .order-details {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 15px;
            margin-top: 30px;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-container">
            <div class="momo-success-header">
                <h1><i class="fas fa-check-circle me-3"></i>Thanh Toán MoMo Thành Công!</h1>
                <p>Cảm ơn bạn đã mua hàng tại TiviShop</p>
            </div>

            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>

            <h4>Đơn hàng #${order.id} đã được xác nhận</h4>
            <p class="lead">Trạng thái: <span class="badge bg-success fs-5">${order.status}</span></p>

            <div class="order-details">
                <div>
                    <div class="order-item">
                        <strong>Khách hàng:</strong>
                        <span>${order.billingName}</span>
                    </div>
                    <div class="order-item">
                        <strong>Điện thoại:</strong>
                        <span>${order.billingPhone}</span>
                    </div>
                    <div class="order-item">
                        <strong>Địa chỉ:</strong>
                        <span>${order.address}</span>
                    </div>
                    <div class="order-item">
                        <strong>Tổng tiền:</strong>
                        <span class="text-danger fs-5"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VND</span>
                    </div>
                    <hr>
                    <c:forEach var="detail" items="${order.orderDetails}">
                        <div class="order-item">
                        <p>Sản phẩm: <span>${detail.product.name} x ${detail.quantity}</span></p>
                            <strong><fmt:formatNumber value="${detail.product.price * detail.quantity}" pattern="#,##0"/> VND</strong>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="button-container mt-3">
                <a href="order-history" class="btn btn-success btn-lg me-3">
                    <i class="fas fa-history me-2"></i>Xem Lịch Sử Đơn Hàng
                </a>
                <a href="products" class="btn-home btn-lg">
                    <i class="fas fa-shopping-bag me-2"></i>Mua Sắm Tiếp
                </a>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>