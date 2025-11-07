<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header>
    <nav class="sidebar" id="adminSidebar">
        <button class="toggle-btn" onclick="toggleSidebar()"><i class="fas fa-arrow-left"></i></button>
        <div class="sidebar-header">
            <a class="sidebar-brand" href="dashboard">
                <div class="logo-img">
                    <i class="fas fa-shield-alt text-white" style="font-size: 18px;"></i>
                </div>
                <span class="brand-text">Admin Panel</span>
            </a>
        </div>
        <ul class="sidebar-nav">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}" 
                   href="dashboard"><i class="fas fa-tachometer-alt me-1"></i> <span>Dashboard </span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('manage-products') ? 'active' : ''}" 
                   href="productss"><i class="fa-solid fa-tv"></i> <span>Quản lý Sản phẩm</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('manage-orders') ? 'active' : ''}" 
                   href="orderss"><i class="fas fa-shopping-cart me-1"></i> <span>Quản lý Đơn hàng</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('manage-users') ? 'active' : ''}" 
                   href="userss"><i class="fas fa-users me-1"></i> <span>Quản lý người dùng</span></a>
            </li>
        </ul>
        <div class="sidebar-footer">
<!--            <a class="nav-link"><i class="fas fa-user"></i> <span>${sessionScope.user.username}</span></a>-->
            <a class="nav-link logout-btn" href="../logout"><i class="fas fa-sign-out-alt"></i> <span>Đăng xuất</span></a>
        </div>
    </nav>
    <style>
        .sidebar {
            background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
            width: 233px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            padding: 20px 0;
            transition: width 0.3s ease;
        }

        .sidebar.collapsed {
            width: 79px;
        }

        .toggle-btn {
            position: absolute;
            top: 20px;
            right: -15px;
            width: 30px;
            height: 30px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease;
        }

        .sidebar.collapsed .toggle-btn {
            transform: rotate(180deg);
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: opacity 0.3s ease;
        }

        .sidebar.collapsed .sidebar-header .brand-text {
            opacity: 0;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: white !important;
            font-weight: 700;
            font-size: 1.3rem;
            transition: all 0.3s ease;
        }

        .sidebar-brand:hover {
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

        .sidebar-brand:hover .logo-img {
            transform: rotate(360deg);
        }

        .brand-text {
            background: linear-gradient(45deg, #fff, #f093fb);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .sidebar-nav {
            flex: 1;
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }

        .nav-item {
            margin: 10px 0;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 12px 20px !important;
            border-radius: 18px;
            margin: 0 10px;
            transition: all 0.3s ease, padding-left 0.3s ease;
            position: relative;
            overflow: hidden;
            font-size: 14px;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .nav-link:hover, .nav-link.active {
            color: white !important;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding-left: 25px;
        }

        .nav-link i {
            margin-right: 8px;
            font-size: 14px;
            width: 20px;
        }

        .sidebar.collapsed .nav-link span {
            display: none;
        }

        .sidebar-footer {
            padding: 17px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-footer .nav-link {
            justify-content: center;
        }

        .logout-btn {
            background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
            color: white !important;
            border-radius: 18px;
            transition: all 0.3s ease, transform 0.3s ease;
        }

        .logout-btn:hover {
            background: linear-gradient(45deg, #ff5252, #ff7979);
            transform: translateY(-5px);
        }

        .sidebar.collapsed .logout-btn span {
            display: none;
        }

        /* Điều chỉnh nội dung chính */
        body {
            margin: 0;
            padding-left: 243px; 
            /*phải*/
            padding-right: 10px; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: #f8f9fa;
            font-family: 'Roboto', sans-serif;
            transition: padding-left 0.3s ease;
        }
        
/*đóng*/
        body.collapsed {
            padding-left: 80px;
        }

        .main-content {
            flex: 1;
            padding: 20px 30px;
            margin: 0 20px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            min-height: calc(100vh - 40px);
            max-width: 1200px;
            transition: max-width 0.3s ease, margin-left 0.3s ease;
        }

        body.collapsed .main-content {
            margin-left: 111px;
            max-width: 1400px;
        }

        @media (max-width: 991px) {
            .sidebar {
                width: 200px;
            }
            body {
                padding-left: 200px;
            }
            body.collapsed {
                padding-left: 80px;
            }
            .main-content {
                padding: 15px 20px;
                margin: 0 15px;
            }
            body.collapsed .main-content {
                margin-left: 95px;
                max-width: 1300px;
            }
            .nav-link {
                font-size: 13px;
                padding: 10px 15px !important;
            }
            .sidebar-brand {
                font-size: 1.2rem;
            }
        }

        @media (max-width: 767px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding-bottom: 10px;
            }
            .sidebar.collapsed {
                width: 100%;
            }
            body {
                padding-left: 0;
            }
            body.collapsed {
                padding-left: 0;
            }
            .main-content {
                padding: 10px 15px;
                margin: 10px;
                max-width: none;
            }
            body.collapsed .main-content {
                margin-left: 10px;
            }
            .sidebar-nav {
                margin: 10px 0;
            }
            .toggle-btn {
                display: none;
            }
        }
    </style>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('adminSidebar');
            const body = document.body;
            sidebar.classList.toggle('collapsed');
            body.classList.toggle('collapsed');
        }
    </script>
</header>