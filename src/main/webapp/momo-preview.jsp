<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Thanh Toán MoMo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fff2e8 0%, #ffdbac 100%);
            min-height: 100vh;
        }
        .momo-container {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(250, 92, 0, 0.2);
            max-width: 1200px;
            margin: 20px auto;
        }
        .momo-header {
            background: linear-gradient(45deg, #FA5C00, #FF8C00);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 25px;
        }
        .qr-section {
            text-align: center;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 15px;
            border: 3px dashed #FA5C00;
        }
        #qrCode {
            width: 250px;
            height: 250px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(250, 92, 0, 0.3);
            transition: all 0.5s ease;
        }
        .countdown {
            font-size: 1.5rem;
            font-weight: bold;
            color: #FA5C00;
            margin-top: 15px;
        }
        .info-section {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            border-left: 5px solid #FA5C00;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .btn-momo-confirm {
            background: linear-gradient(45deg, #FA5C00, #FF8C00);
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 25px;
            padding: 15px 40px;
            width: 100%;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }
        .btn-momo-confirm:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(250, 92, 0, 0.4);
            color: white;
        }
        .btn-momo-confirm:disabled {
            background: #ccc;
            transform: none;
            box-shadow: none;
        }
        .order-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .product-img-small {
            width: auto;
            height: 45px;
            object-fit: cover;
            margin-right: 15px;
        }
        .expired {
            filter: grayscale(100%);
            opacity: 0.5;
        }
        .error-alert {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            border-radius: 10px;
            padding: 15px;
        }
    </style>
</head>
<body>
    <div class="container my-0">
        <div class="momo-container">
            <div class="momo-header">
                <h2>💳 Thanh Toán Qua MoMo</h2>
                <p>Vui lòng quét mã QR để thanh toán</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert error-alert text-center mb-4">${error}</div>
            </c:if>

            <div class="row">
                <!-- QR Section -->
                <div class="col-md-6">
                    <div class="qr-section">
                        <h5><i class="fas fa-qrcode me-2"></i>Mã QR Thanh Toán</h5>
                        <img id="qrCode" src="images/qr-momo1.jpg" alt="QR MoMo 1" class="img-fluid">
                        <div class="countdown" id="countdown">05:00</div>
                        <small class="text-muted">Thời gian còn lại để quét mã</small>
                    </div>
                </div>

                <!-- Info Section -->
                <div class="col-md-6">
                    <div class="info-section">
                        <h5><i class="fas fa-info-circle me-2 text-warning"></i>Thông Tin Đơn Hàng</h5>
                        <div class="mb-1">
                            <strong>Mã đơn tạm: #${pendingOrder.userId}${pendingOrder.createdDate.time}</strong>
                        </div>
                        <div class="mb-1">
                            <strong>Khách hàng:</strong> ${pendingOrder.billingName}<br>
                            <strong>☎️ Điện thoại:</strong> ${pendingOrder.billingPhone}<br>
                            <strong>📧 Email:</strong> ${pendingOrder.billingEmail}
                        </div>
                        <div class="mb-2"> 
                            <strong>Địa chỉ:</strong> ${pendingOrder.address}
                        </div>
                        <hr>
                        <h6>Sản phẩm:</h6>
                        <c:forEach var="item" items="${pendingOrder.cartItems}">
                            <div class="order-item">
                                <img src="images/${item.product.image}" alt="${item.product.name}" class="product-img-small">
                                <div class="flex-grow-1">
                                    <strong>${item.product.name}</strong><br>
                                    <small>Số lượng: ${item.quantity} x <fmt:formatNumber value="${item.product.price}" pattern="#,##0"/> VND</small>
                                </div>
                                <div class="text-end">
                                    <strong><fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0"/> VND</strong>
                                </div>
                            </div>
                        </c:forEach>
                        <hr>
                        <div class="summary-item d-flex justify-content-between fs-5">
                            <span>Tổng tiền:</span>
                            <strong class="text-danger"><fmt:formatNumber value="${pendingOrder.totalAmount}" pattern="#,##0"/> VND</strong>
                        </div>
                        <form action="momo-confirm" method="post" id="confirmForm">
                            <button type="submit" class="btn btn-momo-confirm mt-3" id="confirmBtn">
                                <i class="fas fa-check-circle me-2"></i>Tôi Đã Thanh Toán
                            </button>
                        </form>
                        <a href="checkout" class="btn btn-outline-secondary w-100 mt-1">
                            <i class="fas fa-arrow-left me-2"></i>Quay Lại
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="momo-timer.js"></script>
</body>
</html>