<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Lịch Sử Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        .history-container { 
            background: #fff; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 8px 30px rgba(0,0,0,0.15); 
            max-width: 1200px; 
            margin: 10px auto; 
        }
        .btn-primary { 
            background: #007bff; 
            color: white; 
            font-weight: bold; 
            border-radius: 25px; 
            padding: 12px 30px; 
            transition: all 0.3s ease;
        }
        .btn-primary:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); 
        }
        .btn-view-details { 
            background: #28a745; 
            color: white; 
            font-weight: bold; 
            border-radius: 25px; 
            padding: 6px 12px; 
            transition: all 0.3s ease;
        }
        .btn-view-details:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); 
            background: #218838; 
        }
        .table th, .table td { 
            vertical-align: middle; 
            padding: 12px; 
        }
        .table-dark { 
            background: #4a90e2; 
            color: white; 
        }
        .table-light { 
            background: #f1f3f5; 
            font-weight: bold; 
        }
        .alert-danger { 
            border-radius: 10px; 
            padding: 15px; 
        }
        .product-img { 
            width: auto; 
            height: 50px; 
            object-fit: cover; 
        }
        .order-details-table th, .order-details-table td { 
            text-align: center; 
            vertical-align: middle; 
            padding: 10px; 
        }
        .payment-info { 
            background: #f8f9fa; 
            padding: 15px; 
            border-radius: 8px; 
            margin-top: 20px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }
        .payment-info p { 
            margin: 5px 0; 
        }
        .table th, .table td { text-align: center; }
        .status-pending {color:#fff;font-weight:bold;background-color:#6495ED;padding:4px 21px;border-radius:4px;}
        .status-confirmed {color:#fff;font-weight:bold;background-color:#ff9800;padding:4px 8px;border-radius:4px;}
        .status-cancelled {color:#fff;font-weight:bold;background-color:red;padding:4px 8px;border-radius:4px;}
    </style>
</head>
<body>
    <div class="container my-5 history-container">
        <h1 class="text-center mb-4" style="color: #007bff; font-weight: 600;"><i class="fa-solid fa-clock-rotate-left"></i> Lịch Sử Đơn Hàng</h1>
        <c:if test="${empty orders}">
            <div class="text-center">
                <p class="lead mb-4">Bạn chưa có đơn hàng nào!</p>
                <a href="products" class="btn btn-primary btn-lg">Mua Sắm Ngay</a>
            </div>
        </c:if>
        <c:if test="${not empty orders}">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Mã ĐH</th>
                            <th>Ngày đặt hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Địa chỉ</th>
                            <th>Xem chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#${order.id}</td>
                                <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm" timeZone="GMT+7"/></td>
                                <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VND</td>
                                <td><span class="status-${order.status.toLowerCase()}">${order.status}</span></td>
                                <td><i class="fa-solid fa-location-dot"></i> ${order.address}</td>
                                <td>
                                    <button class="btn btn-sm btn-view-details" type="button" data-bs-toggle="collapse" style="align-content: center"
                                            data-bs-target="#details-${order.id}" aria-expanded="false" aria-controls="details-${order.id}">
                                        <i class="fa-solid fa-eye"></i> Xem
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="p-0">
                                    <div class="collapse" id="details-${order.id}">
                                        <div class="payment-info">
                                            <p><strong>Tên:</strong> ${order.billingName} | <strong>Số điện thoại:</strong> ${order.billingPhone} | <strong>Email:</strong> ${order.billingEmail}</p>
                                        </div>
                                        <div class="card card-body">
                                            <h5 style="text-align: left">Chi Tiết Đơn Hàng</h5>
                                            <c:choose>
                                                <c:when test="${not empty order.orderDetails}">
                                                    <table class="table table-bordered order-details-table">
                                                        <thead>
                                                            <tr>
                                                                <th>Ảnh</th>
                                                                <th>Sản phẩm</th>
                                                                <th>Số lượng</th>
                                                                <th>Đơn giá</th>
                                                                <th>Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="detail" items="${order.orderDetails}">
                                                                <tr>
                                                                    <td>
                                                                        <img src="images/${detail.product.image}" alt="${detail.product.name}" class="product-img">
                                                                    </td>
                                                                    <td>${detail.product.name}</td>
                                                                    <td>${detail.quantity}</td>
                                                                    <td><fmt:formatNumber value="${detail.product.price}" pattern="#,##0"/> VND</td>
                                                                    <td><fmt:formatNumber value="${detail.product.price * detail.quantity}" pattern="#,##0"/> VND</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-danger">Không có chi tiết sản phẩm.</p>
                                                </c:otherwise>
                                            </c:choose>
    
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="text-center mt-4">
                <a href="products" class="btn btn-primary btn-lg"> <i class="fas fa-shopping-bag"></i> Tiếp Tục Mua Sắm</a>
            </div>
        </c:if>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>