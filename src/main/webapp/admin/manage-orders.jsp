<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="headeradmin.jsp"%>
<html>
<head>
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="../css/admin-style.css" rel="stylesheet">
    <style>
        .status-pending {color:#fff;font-weight:bold;background-color:#6495ED;padding:4px 21px;border-radius:4px;}
        .status-confirmed {color:#fff;font-weight:bold;background-color:#ff9800;padding:4px 8px;border-radius:4px;}
        .status-cancelled {color:#fff;font-weight:bold;background-color:red;padding:4px 8px;border-radius:4px;}
        .order-details-table th,.order-details-table td{text-align:center;vertical-align:middle;}
        .product-image{width:auto;height:50px;object-fit:cover;}
        .action-buttons{display:flex;gap:10px;align-items:center;padding-right:10px;}
        .action-buttons form{margin-bottom:0;}
        .action-buttons .form-select{width:120px;}
        .action-buttons .btn{padding:6px 12px;min-width:90px;}
        .table th,.table td{text-align:center;padding-right:40px;}
        .alert-container{position:relative;z-index:1000;margin-bottom:15px;}
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center mb-5" style="color:#007bff;"><i class="fas fa-shopping-cart me-1"></i>Quản lý Đơn hàng</h1>

    <!-- Hiển thị thông báo -->
    <div class="alert-container">
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
    </div>

    <!-- Bảng đơn hàng -->
    <table class="table table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Khách hàng</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Ngày tạo</th>
                <th>Điều chỉnh</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.billingName}</td>
                <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /> VND</td>
                <td><span class="status-${order.status.toLowerCase()}">${order.status}</span></td>
                <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm" timeZone="GMT+7"/></td>
                <td class="action-buttons">
                    <form action="orderss" method="post" class="d-inline">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <select name="status" class="form-select d-inline">
                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}">PENDING</option>
                            <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}">CONFIRMED</option>
                            <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}">CANCELLED</option>
                        </select>
                        <button type="submit" class="btn btn-sm btn-primary">
                            <i class="fas fa-sync"></i> Chỉnh
                        </button>
                    </form>
                </td>
                <td>
                    <a href="orderss?action=view&orderId=${order.id}" class="btn btn-sm btn-info">
                        <i class="fas fa-eye"></i> Xem
                    </a>
                    <form action="orderss" method="post" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <button type="submit" class="btn btn-sm btn-danger" 
                                onclick="return confirm('Xóa đơn hàng này?')">
                            <i class="fas fa-trash"></i> Xóa
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- ✅ Đặt tất cả modal RA NGOÀI BẢNG -->
    <c:forEach var="order" items="${orders}">
        <div class="modal fade" id="orderModal${order.id}" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chi tiết Đơn hàng #${order.id}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${viewOrder != null && viewOrder.id == order.id}">
                            <p><strong>Tên:</strong> ${viewOrder.billingName}</p>
                            <p><strong>Địa chỉ:</strong> ${viewOrder.address}</p>
                            <p><strong>Số điện thoại:</strong> ${viewOrder.billingPhone}</p>
                            <p><strong>Ngày tạo:</strong>
                               <fmt:formatDate value="${viewOrder.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                            
                            <c:if test="${viewOrder.payment != null}">
                                <p><strong>Phương thức:</strong> 
                                    <c:choose>
                                        <c:when test="${viewOrder.payment.transactionId.startsWith('COD')}">Thanh Toán Khi Nhận Hàng (COD)</c:when>
                                        <c:when test="${viewOrder.payment.transactionId.startsWith('MOMO')}">Chuyển Khoản MoMo</c:when>
                                        <c:otherwise>Khác</c:otherwise>
                                    </c:choose>
                                </p>
                                <p><strong>Mã giao dịch:</strong> ${viewOrder.payment.transactionId}</p>
                            </c:if>
                            <p><strong>Trạng thái:</strong>
                               <span class="status-${viewOrder.status.toLowerCase()}">${viewOrder.status}</span>
                            </p>
                            <p><strong>Tổng tiền:</strong>
                               <fmt:formatNumber value="${viewOrder.totalAmount}" pattern="#,##0" /> VND
                            </p>

                            <h6 class="mt-4">Chi tiết sản phẩm</h6>
                            <c:choose>
                                <c:when test="${not empty viewOrder.orderDetails}">
                                    <table class="table table-bordered order-details-table">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Sản phẩm</th>
                                                <th>SL</th>
                                                <th>Đơn giá</th>
                                                <th>Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="detail" items="${viewOrder.orderDetails}">
                                            <tr>
                                                <td>
                                                    <img src="images/${detail.product.image}" 
                                                         alt="${detail.product.name}" class="product-image">
                                                </td>
                                                <td>${detail.product.name}</td>
                                                <td>${detail.quantity}</td>
                                                <td><fmt:formatNumber value="${detail.product.price}" pattern="#,##0" /> VND</td>
                                                <td><fmt:formatNumber value="${detail.quantity * detail.product.price}" pattern="#,##0" /> VND</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-danger">Không có chi tiết sản phẩm.</p>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <c:if test="${viewOrder == null || viewOrder.id != order.id}">
                            <p class="text-danger">Không tìm thấy chi tiết đơn hàng!</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tự động mở modal sau khi xem chi tiết
    <c:if test="${viewOrder != null}">
        var modal = new bootstrap.Modal(document.getElementById('orderModal${viewOrder.id}'));
        modal.show();
    </c:if>
</script>
</body>
</html>
