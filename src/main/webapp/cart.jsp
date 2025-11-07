<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Giỏ Hàng</title>
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
        .cart-container {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            max-width: 1200px;
            margin: 20px auto;
        }
        .cart-title {
            color: #007bff;
            font-weight: 600;
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .btn-add {
            background: #28a745;
            color: white;
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        .btn-sub {
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        .btn-remove {
            background: #dc3545;
            color: white;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s ease;
        }
        .btn-checkout {
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
        .btn-continue-shopping {
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
        .btn-add:hover, .btn-sub:hover, .btn-remove:hover, .btn-checkout:hover, .btn-continue-shopping:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            text-decoration: none;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            padding: 15px;
        }
        .table-dark {
            background: #343a40;
            color: white;
        }
        .total-row {
            font-weight: bold;
            background: #f1f3f5;
            font-size: 1.1rem;
        }
        .error-alert {
            font-size: 1rem;
            font-weight: 500;
            border-radius: 10px;
            padding: 15px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .product-img {
            border-radius: 0px;
            object-fit: cover;
            transition: transform 0.3s ease;
            width: auto;
            height: 70px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .product-img:hover {
            transform: scale(1.1);
        }
        .quantity-input {
            width: 60px;
            text-align: center;
            border-radius: 10px;
            border: 1px solid #ced4da;
            padding: 5px;
        }
        .d-flex.justify-content-end.mt-3 {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .btn-continue-shopping:hover, .btn-checkout:hover {
            color: #FFD700 !important;
        }

    </style>
</head>
<body>
    <div class="container cart-container">
        <h1 class="cart-title"><i class="fas fa-shopping-cart me-2"></i>Giỏ Hàng Của Bạn</h1>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger text-center error-alert">${param.error}</div>
        </c:if>
        <c:if test="${empty sessionScope.cart}">
            <div class="text-center">
                <p class="lead mb-4">Giỏ hàng của bạn đang trống!</p>
                <a href="products" class="btn btn-continue-shopping btn-lg"><i class="fas fa-shopping-bag"></i> Mua Sắm Ngay</a>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.cart}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Hình Ảnh</th>
                            <th>Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Tổng</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <tr>
                                <td><img src="images/${item.product.image}" alt="${item.product.name}" class="product-img"></td>
                                <td>${item.product.name}</td>
                                <td><fmt:formatNumber value="${item.product.price}" pattern="#,##0" /> VND</td>
                                <td>
                                    <form action="cart" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="decrease">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <button type="submit" class="btn btn-sm btn-sub"><i class="fas fa-minus"></i></button>
                                    </form>
                                    <form action="cart" method="post" class="d-inline" id="updateForm-${item.product.id}">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" class="quantity-input" onchange="this.form.submit();">
                                    </form>
                                    <form action="cart" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="increase">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <button type="submit" class="btn btn-sm btn-add"><i class="fas fa-plus"></i></button>
                                    </form>
                                </td>
                                <td><fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0" /> VND</td>
                                <td>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <input type="hidden" name="quantity" value="0">
                                        <button type="submit" class="btn btn-sm btn-remove" onclick="return confirmDelete()"><i class="fas fa-trash"></i> Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr class="total-row">
                            <td colspan="4" class="text-end">Tổng Cộng:</td>
                            <td colspan="2">
                                <c:set var="total" value="0"/>
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <c:set var="total" value="${total + (item.product.price * item.quantity)}"/>
                                </c:forEach>
                                <strong><fmt:formatNumber value="${total}" pattern="#,##0" /> VND</strong>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="d-flex justify-content-end mt-3 gap-3">
                <a href="products" class="btn btn-continue-shopping btn-lg"><i class="fas fa-shopping-bag"></i> Tiếp Tục Mua Sắm</a>
                <a href="checkout" class="btn btn-checkout btn-lg"><i class="fas fa-credit-card"></i> Tiến Hành Thanh Toán</a>
            </div>
        </c:if>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete() {
            return confirm("Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?");
        }
    </script>
</body>
</html>