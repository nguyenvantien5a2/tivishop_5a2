<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --accent-color: #f59e0b;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --dark-color: #1f2937;
            --light-gray: #f8fafc;
            --border-color: #e2e8f0;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: white;
            min-height: 100vh;
            color: var(--text-primary);
        }

        .main-container {
            background: white;
            margin: 0.3rem auto;
            max-width: 1400px;
        }

        .product-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.4rem;
            text-align: center;
        }

        .product-title {
            font-size: 2.4rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .product-info-container {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 1.5rem 1.5rem;
            margin: 1rem 0;
            box-shadow: var(--shadow-lg);
        }

        .product-content {
            padding: 0;
        }

        /* Image Gallery Styles */
        .image-gallery {
            position: relative;
            background: var(--light-gray);
            border-radius: 20px;
            padding: 2rem;
            height: 100%;
        }

        .carousel-container {
            position: relative;
            margin-bottom: 1.5rem;
            border-radius: 16px;
            overflow: hidden;
            background: transparent;
            box-shadow: var(--shadow-md);
            width: 100%;
            margin-left: 0; /* Đảm bảo không có margin trái */
            margin-right: auto; /* Căn giữa theo chiều ngang */
        }

        .carousel-inner {
            background: transparent;
            width: 100%; /* Đảm bảo chiều rộng 100% */
        }
        
        .carousel-item img {
            width: 100%;
            max-width: 668px;
            height: 395px;
            object-fit: contain;
            background: transparent;
            margin: 0 auto; /* Căn giữa, nhưng có thể điều chỉnh nếu cần */
            padding: 0; /* Loại bỏ padding để không có viền trắng */
            display: block; /* Đảm bảo không có khoảng cách mặc định từ inline-block */
        }
        
        .carousel-item img:hover {
            transform: scale(1.02);
        }

        .carousel-control-prev, .carousel-control-next {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            top: 50%;
            transform: translateY(-50%);
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .carousel-control-prev:hover, .carousel-control-next:hover {
            background: white;
            transform: translateY(-50%) scale(1.1);
            box-shadow: var(--shadow-lg);
        }

        .carousel-control-prev-icon, .carousel-control-next-icon {
            filter: invert(1);
        }

        .thumbnails {
            display: flex;
            gap: 0.75rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .thumbnail {
            width: 100px;
            height: 70px;
            border-radius: 12px;
            object-fit: contain;
            background: transparent;
            cursor: pointer;
            border: 3px solid transparent;
            transition: all 0.3s ease;
            opacity: 0.7;
        }

        .thumbnail:hover, .thumbnail.active {
            border-color: var(--primary-color);
            opacity: 1;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Product Info Styles */
        .product-info {
            background: var(--light-gray);
            padding: 2.1rem;
            border-radius: 20px;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .product-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-color));
        }

        .price-rating-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .price-section {
            flex: 1.7; 
            min-width: 200px;
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            align-items: left; 
            border-left: 4px solid var(--primary-color);
            position: relative;
        }

        .rating-container {
            flex: 1; 
            min-width: 200px;
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            align-items: center; 
            text-align: center;
        }

        .price-section {
            border-left: 4px solid var(--primary-color);
            position: relative;
        }

        .promo-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .price-label {
            margin-top: 9px;
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 0.1rem;
        }

        .price-value {
            font-size: 2.1rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 0;
        }

        .price-original {
            text-decoration: line-through;
            color: #999;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: var(--text-primary);
        }

        .detail-value {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .quantity-badge {
            background: var(--success-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .description-section {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            margin: 2rem 0;
            box-shadow: var(--shadow-sm);
        }

        .description-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Rating Styles */
        .rating-container {
            text-align: center;
        }

        .rating-score {
            font-size: 2.3rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 0.2rem;
        }

        .stars-display {
            margin: 1rem 0;
        }

        .star {
            color: #e5e7eb;
            font-size: 1.1rem;
            margin: 0 0.1rem;
            transition: color 0.3s ease;
        }

        .star.filled {
            color: var(--accent-color);
        }

        .rating-count {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        /* Button Styles */
        .btn-add-cart {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            width: 100%;
            margin-top: 1.5rem;
        }

        .btn-add-cart::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-add-cart:hover::before {
            left: 100%;
        }

        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            color: #FFD700;
        }

        /* Reviews Section */
        .review-section {
            background: white;
            margin: 2rem 0;
            padding: 3rem 2rem;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
        }

        .review-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .review-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .review-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        .review-card {
            background: var(--light-gray);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            position: relative;
        }

        .review-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 16px 16px 0 0;
        }

        .review-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .review-header-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .reviewer-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .reviewer-name {
            font-weight: 600;
            color: var(--text-primary);
        }

        .review-date {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .review-comment {
            color: var(--text-primary);
            line-height: 1.6;
            margin-top: 1rem;
        }

        .review-hidden {
            display: none;
        }

        .btn-show-more {
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: block;
            margin: 2rem auto;
        }

        .btn-show-more:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Review Form */
        .review-form {
            background: var(--light-gray);
            padding: 2.5rem;
            border-radius: 20px;
            margin-top: 3rem;
            border: 1px solid var(--border-color);
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: var(--text-primary);
            text-align: center;
        }

        .form-select, .form-control {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-select:focus, .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .btn-submit-review {
            background: linear-gradient(135deg, var(--success-color), #059669);
            border: none;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit-review:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
            }
            
            .product-info-container {
                margin: 1rem 0;
                padding: 2rem 1rem;
            }
            
            .review-section {
                margin: 1rem 0;
                padding: 2rem 1rem;
            }
            
            .product-title {
                font-size: 2rem;
            }
            
            .price-value {
                font-size: 1.8rem;
            }
            
            .rating-score {
                font-size: 2.5rem;
            }

            .carousel-container {
                width: 100%;
            }

            .carousel-item img {
                width: 100%;
                max-width: 600px;
                height: auto;
            }

            .price-rating-container {
                flex-direction: column;
            }
        }
        /* Button Styles */
        .btn-out-of-stock {
            background: linear-gradient(135deg, #9ca3af, #6b7280);
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            position: relative;
            overflow: hidden;
            width: 100%;
            margin-top: 1.5rem;
            cursor: not-allowed; 
            opacity: 0.8; 
        }

        .btn-out-of-stock:hover {
            background: linear-gradient(135deg, #9ca3af, #6b7280); 
            box-shadow: var(--shadow-lg); 
            transform: translateY(-2px); 
        }

        .btn-out-of-stock::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-out-of-stock:hover::before {
            left: 100%; 
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Header -->
        <div class="product-header">
            <h1 class="product-title">${product.name}</h1>
        </div>

        <!-- Product Info Container -->
        <div class="product-info-container">
            <div class="row">
                <!-- Image Gallery -->
                <div class="col-lg-6">
                    <div class="image-gallery">
                        <div class="carousel-container">
                            <div id="productCarousel" class="carousel slide">
                                <div class="carousel-inner">
                                    <c:forEach var="img" items="${product.images}" varStatus="status">
                                        <div class="carousel-item ${status.first ? 'active' : ''}">
                                            <img src="images/${img}" class="d-block" alt="${product.name}">
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                        
                        <!-- Thumbnails -->
                        <div class="thumbnails">
                            <c:forEach var="img" items="${product.images}" varStatus="status">
                                <img src="images/${img}" class="thumbnail ${status.first ? 'active' : ''}" 
                                     data-bs-target="#productCarousel" data-bs-slide-to="${status.index}" 
                                     alt="Thumbnail ${status.index + 1}">
                            </c:forEach>
                        </div>
                        
                        <!-- Description -->
                        <div class="description-section">
                            <h3 class="description-title">
                                <i class="fas fa-info-circle"></i> Mô tả sản phẩm
                            </h3>
                            <p>${product.description}</p>
                        </div>
                    </div>
                </div>

                <!-- Product Info -->
                <div class="col-lg-6">
                    <div class="product-info">
                        <!-- Price and Rating Container -->
                        <div class="price-rating-container">
                            <!-- Price -->
                            <div class="price-section">
                                <c:if test="${product.discountPercentage > 0}">
                                    <div class="promo-badge">Giảm ${product.discountPercentage}%</div>
                                </c:if>
                                <div class="price-label">Giá gốc:</div>
                                <c:if test="${product.originalPrice > product.price}">
                                    <div class="price-original">
                                        <fmt:formatNumber value="${product.originalPrice}" pattern="#,##0" /> VND
                                    </div>
                                </c:if>
                                <div class="price-label">Giá sau giảm:</div>
                                <div class="price-value">
                                    <fmt:formatNumber value="${product.price}" pattern="#,##0" /> VND
                                </div>
                            </div>

                            <!-- Rating -->
                            <div class="rating-container">
                                <div class="rating-score">
                                    <fmt:formatNumber value="${product.averageRating}" pattern="#.#"/>
                                </div>
                                <div class="stars-display">
                                    <c:forEach var="i" begin="1" end="5">
                                        <i class="fas fa-star star ${i <= product.averageRating ? 'filled' : ''}"></i>
                                    </c:forEach>
                                </div>
                                <div class="rating-count">(${product.reviewCount} lượt đánh giá)</div>
                            </div>
                        </div>

                        <!-- Product Details -->
                        <div class="detail-row">
                            <span class="detail-label">Thương hiệu:</span>
                            <span class="detail-value">${product.brand}</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Tình trạng:</span>
                            <span class="quantity-badge">Còn ${product.quantity} sản phẩm</span>
                        </div>

                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <form action="cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn btn-add-cart">
                                        <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-out-of-stock disabled" disabled>
                                    <i class="fas fa-ban me-2"></i>Hết Sản Phẩm
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reviews Section -->
        <div class="review-section">
            <div class="review-header">
                <h3 class="review-title">Đánh giá từ khách hàng</h3>
                <p class="review-subtitle">
                    ⭐ <fmt:formatNumber value="${product.averageRating}" pattern="#.#"/>/5 (${product.reviewCount} lượt đánh giá)
                </p>
            </div>

            <div id="reviewList">
                <c:forEach var="review" items="${reviews}" varStatus="status">
                    <div class="review-card ${status.index >= 2 ? 'review-hidden' : ''}">
                        <div class="review-header-info">
                            <div class="reviewer-info">
                                <div class="reviewer-avatar">
                                    ${review.username.substring(0, 1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="reviewer-name">${review.username}</div>
                                    <div class="stars-display">
                                        <c:forEach var="i" begin="1" end="5">
                                            <i class="fas fa-star star ${i <= review.rating ? 'filled' : ''}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <div class="review-date">
                                <fmt:formatDate value="${review.createdDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                        <div class="review-comment">${review.comment}</div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${reviews.size() > 2}">
                <button id="showMoreReviews" class="btn-show-more">
                    <i class="fas fa-chevron-down"></i> Hiển thị thêm đánh giá
                </button>
            </c:if>
            
            <!-- Review Form -->
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger alert-dismissible fade show mt-4" role="alert">
                    ${requestScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form đánh giá - chỉ hiển thị nếu đủ quyền -->
            <c:if test="${sessionScope.user != null && canReview}">
                <div class="review-form mt-5 p-4 border rounded bg-light">
                    <h4 class="mb-4">
                        <i class="fas fa-edit text-primary"></i> Viết đánh giá của bạn
                    </h4>
                    <form action="product-detail" method="post">
                        <input type="hidden" name="productId" value="${product.id}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Đánh giá của bạn:</label>
                            <select name="rating" class="form-select" required>
                                <option value="5">⭐⭐⭐⭐⭐ Xuất sắc</option>
                                <option value="4">⭐⭐⭐⭐ Rất tốt</option>
                                <option value="3">⭐⭐⭐ Tốt</option>
                                <option value="2">⭐⭐ Trung bình</option>
                                <option value="1">⭐ Kém</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Nhận xét:</label>
                            <textarea name="comment" class="form-control" rows="5" 
                                      placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm..." required></textarea>
                        </div>

                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="fas fa-paper-plane"></i> Gửi đánh giá
                        </button>
                    </form>
                </div>
            </c:if>

            <!-- Nếu không đủ quyền nhưng đã đăng nhập -->
            <c:if test="${sessionScope.user != null && !canReview}">
                <div class="alert alert-info mt-4">
                    <i class="fas fa-info-circle"></i>
                    Bạn chỉ có thể đánh giá sản phẩm sau khi nhận hàng thành công (trạng thái <strong>DELIVERED</strong>).
                </div>
            </c:if>
        </div>
    </div>

    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Show more reviews functionality
            const showMoreBtn = document.getElementById('showMoreReviews');
            if (showMoreBtn) {
                showMoreBtn.addEventListener('click', function() {
                    document.querySelectorAll('.review-hidden').forEach(review => {
                        review.classList.remove('review-hidden');
                    });
                    showMoreBtn.style.display = 'none';
                });
            }

            // Sync thumbnails with carousel
            const carousel = document.getElementById('productCarousel');
            if (carousel) {
                carousel.addEventListener('slide.bs.carousel', function (event) {
                    document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
                        thumb.classList.toggle('active', index === event.to);
                    });
                });

                // Click thumbnail to change slide
                document.querySelectorAll('.thumbnail').forEach(thumb => {
                    thumb.addEventListener('click', function () {
                        const slideTo = parseInt(this.getAttribute('data-bs-slide-to'));
                        const carouselInstance = bootstrap.Carousel.getInstance(carousel);
                        if (carouselInstance) {
                            carouselInstance.to(slideTo);
                        }
                    });
                });
            }

            // Add smooth animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            // Observe review cards
            document.querySelectorAll('.review-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'all 0.6s ease';
                observer.observe(card);
            });
        });
    </script>
</body>
</html>