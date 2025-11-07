<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .footer {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: rgba(255, 255, 255, 0.9);
        padding: 60px 0 20px;
        position: relative;
        overflow: hidden;
        width: 100%;
    }

    .footer::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 100%);
        pointer-events: none;
    }

    .footer-section h5 {
        color: white;
        font-weight: 700;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 10px;
    }

    .footer-section h5::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 3px;
        background: linear-gradient(45deg, #f093fb, #f5576c);
    }

    .footer-section ul {
        list-style: none;
        padding: 0;
    }

    .footer-section ul li {
        margin-bottom: 12px;
    }

    .footer-section ul li a {
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
    }

    .footer-section ul li a:hover {
        color: white;
        transform: translateX(5px);
    }

    .contact-info {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .contact-item {
        display: flex;
        align-items: center;
        gap: 12px;
        color: rgba(255, 255, 255, 0.8);
        transition: color 0.3s ease;
    }

    .contact-item:hover {
        color: white;
    }

    .contact-item i {
        font-size: 20px;
        color: #f093fb;
        min-width: 25px;
        text-align: center;
    }

    .social-icons {
        display: flex;
        gap: 15px;
        margin-top: 20px;
    }

    .social-icons a {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 18px;
    }

    .social-icons a:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .social-icons .facebook {
        background: linear-gradient(45deg, #1877f2, #3b5998);
    }

    .social-icons .twitter {
        background: linear-gradient(45deg, #1da1f2, #0e71c8);
    }

    .social-icons .instagram {
        background: linear-gradient(45deg, #e4405f, #c13584);
    }

    .social-icons .youtube {
        background: linear-gradient(45deg, #ff0000, #c4302b);
    }

    .footer-divider {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        margin: 40px 0 20px;
    }

    .copyright {
        text-align: center;
        color: rgba(255, 255, 255, 0.7);
        font-size: 14px;
    }

    .brand-footer {
        background: linear-gradient(45deg, #f093fb, #f5576c);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        font-weight: 700;
    }

    /* Floating Buttons */
    .floating-buttons {
        position: fixed;
        bottom: 30px;
        right: 30px;
        z-index: 1000;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .float-btn {
        width: 55px;
        height: 55px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-decoration: none;
        font-size: 22px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        position: relative;
        overflow: hidden;
        border: none;
    }

    .float-btn::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.3);
        transition: all 0.6s ease;
        transform: translate(-50%, -50%);
    }

    .float-btn:hover::before {
        width: 100%;
        height: 100%;
    }

    .float-btn:hover {
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
    }

    .float-btn:active {
        transform: translateY(-2px) scale(1.05);
    }

    /* Scroll to Top Button */
    .scroll-top-btn {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0%, 100% {
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        50% {
            box-shadow: 0 5px 30px rgba(102, 126, 234, 0.6);
        }
    }

    /* Chat Button */
    .chat-btn {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
    }

    /* Phone Button */
    .phone-btn {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        animation: ring 3s infinite;
    }

    @keyframes ring {
        0%, 100% {
            transform: rotate(0deg);
        }
        10%, 30% {
            transform: rotate(-10deg);
        }
        20%, 40% {
            transform: rotate(10deg);
        }
    }

    .phone-btn:hover {
        animation: none;
    }

    /* Support Button */
    .support-btn {
        background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
    }

    /* Tooltip */
    .float-btn .tooltip-text {
        position: absolute;
        left: auto;
        right: 70px;
        background: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 14px;
        white-space: nowrap;
        opacity: 0;
        pointer-events: none;
        transition: all 0.3s ease;
    }

    .float-btn .tooltip-text::after {
        content: '';
        position: absolute;
        right: -8px;
        left: auto;
        top: 50%;
        transform: translateY(-50%);
        border: 4px solid transparent;
        border-left-color: rgba(0, 0, 0, 0.8);
        border-right-color: transparent;
    }

    .float-btn:hover .tooltip-text {
        opacity: 1;
        right: 65px;
    }

    /* Hide on scroll */
    .float-btn.hidden {
        opacity: 0;
        transform: translateY(100px);
        pointer-events: none;
    }

    @media (max-width: 767px) {
        .footer-section {
            margin-bottom: 30px;
        }

        .social-icons {
            justify-content: center;
        }

        .contact-info {
            align-items: center;
            text-align: center;
        }

        .contact-item {
            justify-content: center;
        }

        .floating-buttons {
            right: 15px;
            bottom: 15px;
        }

        .float-btn {
            width: 50px;
            height: 50px;
            font-size: 20px;
        }

        .float-btn .tooltip-text {
            display: none;
        }
    }
</style>

<!-- Floating Button - Scroll to Top (Right) -->
<div class="floating-buttons">
    <button class="float-btn scroll-top-btn" onclick="scrollToTop()" title="Lên đầu trang">
        <i class="fas fa-arrow-up"></i>
        <span class="tooltip-text">Lên đầu trang</span>
    </button>
</div>

<footer class="footer">
    <div class="container">
        <div class="row">
            <!-- Về Chúng Tôi Section -->
            <div class="col-md-4">
                <div class="footer-section">
                    <h5><i class="fas fa-info-circle me-2"></i>Về Chúng Tôi</h5>
                    <p class="footer-description"> 
                        TV Store là cửa hàng hàng đầu cung cấp các sản phẩm TV chất lượng cao từ các thương hiệu nổi tiếng. Chúng tôi cam kết mang đến trải nghiệm mua sắm tuyệt vời với dịch vụ khách hàng xuất sắc.
                    </p>
                </div>
            </div>

            <!-- Liên Kết Section -->
            <div class="col-md-4">
                <div class="footer-section">
                    <h5><i class="fas fa-link me-2"></i>Liên Kết</h5>
                    <ul>
                        <li><a href="products">Trang Chủ</a></li>
                        <li><a href="cart">Giỏ Hàng</a></li>
                        <li><a href="order-history">Lịch Sử</a></li>
                        <li><a href="login">Đăng Nhập</a></li>
                        <li><a href="profile">Cá Nhân</a></li>
                    </ul>
                </div>
            </div>

            <!-- Liên Hệ Section -->
            <div class="col-md-4">
                <div class="footer-section">
                    <h5><i class="fas fa-phone me-2"></i>Liên Hệ</h5>
                    <div class="contact-info">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <span>support@tvstore.com</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone-alt"></i>
                            <span>0909 123 456</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>68 Nguyễn Chí Thanh, phường Láng, Hà Nội</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-clock"></i>
                            <span>8:00 - 22:00 (Hàng ngày)</span>
                        </div>

                        <div class="social-icons">
                            <a href="#" class="facebook" target="_blank" title="Facebook">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="twitter" target="_blank" title="Twitter">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a href="#" class="instagram" target="_blank" title="Instagram">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a href="#" class="youtube" target="_blank" title="YouTube">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-divider"></div>

        <div class="copyright">
            <p class="mb-0">
                © 2025 <span class="brand-footer">TV Store</span>. All Rights Reserved. 
                |  <span class="brand-footer">Nguyen Van Tien</span>
            </p>
        </div>
    </div>
</footer>

<script>
    // Scroll to Top Function
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }

    // Show/Hide Scroll to Top Button based on scroll position
    window.addEventListener('scroll', function() {
        const scrollTopBtn = document.querySelector('.scroll-top-btn');
        if (window.pageYOffset > 300) {
            scrollTopBtn.classList.remove('hidden');
        } else {
            scrollTopBtn.classList.add('hidden');
        }
    });

    // Add bounce effect when clicking buttons
    document.querySelectorAll('.float-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            this.style.animation = 'none';
            setTimeout(() => {
                this.style.animation = '';
            }, 10);
        });
    });
</script>
