<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-top: 0px; }
        .product-card { 
            background: #fff; 
            border-radius: 15px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); 
            transition: transform 0.3s ease, box-shadow 0.3s ease; 
            position: relative; 
            overflow: hidden;
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .product-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 8px 25px rgba(0,0,0,0.15); 
        }
        .product-image { 
            width: 100%; 
            height: 176px;
            object-fit: contain;
            border-radius: 8px; 
            margin-bottom: 15px;
            display: block;
            max-width: 100%;
        }
        .promo-badge { 
            position: absolute; 
            top: 10px; 
            left: 10px; 
            background: linear-gradient(45deg, #ff6b6b, #ee5a52); 
            color: white; 
            padding: 5px 10px; 
            border-radius: 20px; 
            font-size: 12px; 
            font-weight: bold;
        }
        .price-original { text-decoration: line-through; color: #999; font-size: 14px; }
        .price-discount { color: #e74c3c; font-size: 18px; font-weight: bold; }
        .rating { color: #f39c12; }
        .review-count { font-size: 12px; color: #666; }
        .btn-add-cart { background: linear-gradient(45deg, #3498db, #2980b9); color: white; border: none; padding: 10px 20px; border-radius: 25px; width: 100%; }
        .btn-add-cart:hover { background: linear-gradient(45deg, #2980b9, #3498db); transform: scale(1.05); color: #FFD700; }
        .btn-secondary { background-color: #ccc; color: white; border: none; padding: 10px 20px; border-radius: 25px; width: 100%; }
        .filter-section { background-color: #fff; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 0px; margin-top: 20px}
        .brand-logos { display: flex; justify-content: space-around; margin-top: 20px; }
        .brand-logo { width: 100px; height: 50px; object-fit: contain; cursor: pointer; transition: transform 0.3s; }
        .brand-logo:hover { transform: scale(1.1); }
        .btn-filter { background: linear-gradient(45deg, #1E90FF, #0d6efd); border: none; color: white; padding: 10px 20px; border-radius: 25px; }
        .btn-filter:hover { background: linear-gradient(45deg, #0d6efd, #1E90FF); }
        h1 { color: #1E90FF; text-align: center; margin-bottom: 30px; }
        .banner-carousel {
            margin-top: 0px;
        }
        .banner-container {
            width: 100%;
            height: 252px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        .banner-carousel .carousel-item img {
            width: 100%;
            height: 252px;
            object-fit: contain;
            max-width: 100%;
            display: block;
        }
    </style>
    <meta http-equiv="cache-control" content="max-age=3600">
</head>
<body>
    <div class="container my-4">
        <div id="bannerCarousel" class="carousel slide banner-carousel" data-bs-ride="carousel" data-bs-interval="3000">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="banner-container">
                         <a href="${pageContext.request.contextPath}/product-detail?id=3">
                        <img src="${pageContext.request.contextPath}/images/banner1.jpg" class="d-block w-100" alt="Banner 1">
                         </a>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="banner-container">
                        <img src="${pageContext.request.contextPath}/images/banner2.jpg" class="d-block w-100" alt="Banner 2">
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="banner-container">
                        <img src="${pageContext.request.contextPath}/images/banner3.jpg" class="d-block w-100" alt="Banner 3">
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="2"></button>
            </div>
        </div>
        <div class="filter-section">
            <h4 class="mb-3"><i class="fa-solid fa-filter"></i> Lọc Theo Thương Hiệu Và Giá</h4>
            <form action="products" method="get">
                <div class="row">
                    <div class="col-md-4">
                        <select class="form-select" name="brand">
                            <option value="">Tất Cả Thương Hiệu</option>
                            <c:forEach var="b" items="${brands}">
                                <option value="${b}" ${b eq selectedBrand ? 'selected' : ''}>${b}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" name="sort">
                            <option value="">Sắp Xếp Theo Giá</option>
                            <option value="price_desc" ${'price_desc' eq selectedSort ? 'selected' : ''}>Giá Cao Đến Thấp</option>
                            <option value="price_asc" ${'price_asc' eq selectedSort ? 'selected' : ''}>Giá Thấp Đến Cao</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-filter">Lọc</button>
                    </div>
                </div>
            </form>
            <div class="brand-logos">
                <a href="products?brand=Samsung"><img src="${pageContext.request.contextPath}/images/logo/sslogo.jpg" alt="Samsung" class="brand-logo"></a>
                <a href="products?brand=LG"><img src="${pageContext.request.contextPath}/images/logo/lg_logo.png" alt="LG" class="brand-logo"></a>
                <a href="products?brand=Sony"><img src="${pageContext.request.contextPath}/images/logo/snlogo.jpg" alt="Sony" class="brand-logo"></a>
                <a href="products?brand=TCL"><img src="${pageContext.request.contextPath}/images/logo/tcl_logo.png" alt="TCL" class="brand-logo"></a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="product-grid">
            <c:forEach var="p" items="${products}">
                <div class="product-card">
                    <c:if test="${p.discountPercentage > 0}">
                        <div class="promo-badge">Giảm ${p.discountPercentage}%</div>
                    </c:if>
                    <a href="product-detail?id=${p.id}">
                        <img src="${pageContext.request.contextPath}/images/${p.image}" class="product-image" alt="${p.name}">
                    </a>
                    <div class="text-center">
                        <h5 class="mb-2">${p.name}</h5>
                        <p class="text-muted small mb-2">${p.description}</p>
                        <div class="mb-2">
                            <c:if test="${p.originalPrice > p.price}">
                                <span class="price-original"><fmt:formatNumber value="${p.originalPrice}" pattern="#,##0" /> VND</span><br>
                            </c:if>
                            <span class="price-discount"><fmt:formatNumber value="${p.price}" pattern="#,##0" /> VND</span>
                        </div>
                        <p class="small mb-2"><strong>Thương hiệu:</strong> ${p.brand}</p>
                        <div class="rating mb-2">
                            <c:forEach var="i" begin="1" end="1">
                                <i class="fas fa-star ${i <= p.averageRating ? 'filled' : ''}"></i>
                            </c:forEach>
                            <span class="review-count"><fmt:formatNumber value="${p.averageRating}" pattern="#.#"/>/5 (${p.reviewCount} đánh giá)</span>
                            <span class="ms-3 text-muted">SL: ${p.quantity}</span>
                        </div>
                            <c:choose>
                                <c:when test="${p.quantity > 0}">
                                    <form id="cartForm-${p.id}" action="cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <button type="button" onclick="addToCart(${p.id})" class="btn btn-add-cart">
                                            <i class="fas fa-shopping-cart me-2"></i>Thêm Vào Giỏ
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary disabled" disabled>
                                        <i class="fas fa-ban me-2"></i>Hết Sản Phẩm
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        <a href="product-detail?id=${p.id}" class="text-decoration-none small text-primary mt-2 d-block">Xem chi tiết</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function addToCart(productId) {
        if (confirm("Thêm sản phẩm vào giỏ hàng?")) {
            document.getElementById("cartForm-" + productId).submit();
        }
    }
    document.addEventListener('DOMContentLoaded', function() {
        const stars = document.querySelectorAll('.fas.fa-star');
        stars.forEach(star => {
            if (star.classList.contains('filled')) {
                star.style.color = '#f39c12';
            }
        });
    });
</script>