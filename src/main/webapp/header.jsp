<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .navbar-custom {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        backdrop-filter: blur(20px);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
        padding: 0.5rem 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
        height: 70px;
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: white !important;
        font-weight: 700;
        font-size: 1.3rem;
        transition: all 0.3s ease;
        flex-shrink: 0;
        margin-right: 15px;
    }

    .navbar-brand:hover {
        color: #f093fb !important;
        transform: translateY(-2px);
    }

    .logo-img {
        width: 35px;
        height: 35px;
        background: linear-gradient(45deg, #f093fb, #f5576c);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 8px;
        transition: transform 0.3s ease;
    }

    .navbar-brand:hover .logo-img {
        transform: rotate(360deg);
    }

    .brand-text {
        background: linear-gradient(45deg, #fff, #f093fb);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .navbar-toggler {
        border: none;
        padding: 0.5rem;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 12px;
        transition: all 0.3s ease;
    }

    .navbar-toggler:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(1.1);
    }

    .navbar-toggler:focus {
        box-shadow: none;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.8%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='m4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    .search-container {
        position: relative;
        max-width: 300px;
        width: 100%;
        flex-shrink: 1;
        margin: 0 15px;
    }

    .search-input {
        background: rgba(255, 255, 255, 0.15);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 25px;
        color: white;
        padding: 10px 40px 10px 16px;
        font-size: 13px;
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
        width: 100%;
    }

    .search-input::placeholder {
        color: rgba(255, 255, 255, 0.7);
    }

    .search-input:focus {
        background: rgba(255, 255, 255, 0.2);
        border-color: #f093fb;
        box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.2);
        color: white;
        outline: none;
    }

    .search-btn {
        position: absolute;
        right: 125px;
        top: 50%;
        transform: translateY(-50%);
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        border: none;
        border-radius: 50%;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        color: white;
    }

    .search-btn:hover {
        transform: translateY(-50%) scale(1.1);
        box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
    }

    .navbar-nav {
        flex-shrink: 0;
    }

    .nav-link {
        color: rgba(255, 255, 255, 0.9) !important;
        font-weight: 500;
        padding: 8px 12px !important;
        border-radius: 18px;
        margin: 0 2px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        font-size: 14px;
        white-space: nowrap;
    }

    .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        transition: all 0.3s ease;
        z-index: -1;
        border-radius: 18px;
    }

    .nav-link:hover {
        color: white !important;
        transform: translateY(-1px);
    }

    .nav-link:hover::before {
        left: 0;
    }

    .nav-link i {
        margin-right: 6px;
        font-size: 14px;
    }

    .cart-count {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
        border-radius: 10px;
        padding: 2px 6px;
        font-size: 11px;
        font-weight: 600;
        margin-left: 3px;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }

    .logout-btn {
        background: linear-gradient(45deg, #ff6b6b, #ff8e8e) !important;
        color: white !important;
    }

    .logout-btn::before {
        background: linear-gradient(45deg, #ff5252, #ff7979) !important;
    }

    .logout-btn:hover {
        box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
    }

    /* Đảm bảo container có đủ không gian */
    .navbar .container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: nowrap;
        padding: 0 20px;
    }

    .navbar-collapse {
        display: flex;
        align-items: center;
        flex: 1;
        justify-content: space-between;
    }

    @media (max-width: 991px) {
        .navbar-collapse {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 15px;
            margin-top: 10px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            flex-direction: column;
        }

        .nav-item {
            margin-bottom: 10px;
        }

        .nav-link {
            justify-content: center;
            padding: 12px !important;
            text-align: center;
        }

        .search-container {
            margin: 10px auto;
            max-width: none;
        }
    }

    /* Tối ưu cho màn hình nhỏ hơn */
    @media (max-width: 1200px) {
        .nav-link {
            padding: 8px 10px !important;
            font-size: 13px;
        }
        
        .search-container {
            max-width: 250px;
        }
        
        .navbar-brand {
            font-size: 1.2rem;
        }
    }

    @media (max-width: 992px) {
        .search-container {
            max-width: 200px;
        }
        
        .nav-link {
            padding: 6px 8px !important;
            font-size: 12px;
        }
    }

    body {
        padding-top: 70px;
        margin-bottom: 100px;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    main {
        flex: 1 0 auto;
    }

    footer {
        flex-shrink: 0;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="products">
            <div class="logo-img">
                <i class="fas fa-tv text-white" style="font-size: 18px;"></i>
            </div>
            <span class="brand-text">TV Store</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <form action="search" method="get" class="search-container">
                <input class="search-input" type="search" name="query" placeholder="Tìm kiếm..." aria-label="Search">
                <button class="search-btn" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="products"><i class="fas fa-home"></i> Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart"><i class="fas fa-shopping-cart"></i> Giỏ Hàng 
                        <span class="cart-count badge bg-primary ms-1">
                            <c:set var="cartCount" value="0"/>
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <c:set var="cartCount" value="${cartCount + item.quantity}"/>
                            </c:forEach>
                            <c:out value="${cartCount}"/>
                        </span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="order-history"><i class="fa-solid fa-clock-rotate-left"></i> Lịch Sử </a>
                </li>
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="profile"><i class="fas fa-user"></i> ${sessionScope.user.username}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link logout-btn" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="login"><i class="fas fa-sign-in-alt"></i> Đăng Nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register"><i class="fas fa-user-plus"></i> Đăng Ký</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>