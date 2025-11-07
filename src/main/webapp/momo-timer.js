// webapp/js/momo-timer.js
(function () {
    let timeLeft = 300; // 5 phút tính bằng giây
    const countdownEl = document.getElementById('countdown');
    const qrCodeEl = document.getElementById('qrCode');
    const confirmBtn = document.getElementById('confirmBtn');

    if (!countdownEl || !qrCodeEl || !confirmBtn) {
        console.error("Không tìm thấy một hoặc nhiều phần tử (countdown, qrCode, confirmBtn)!");
        return;
    }

    function updateTimer() {
        console.log('Thời gian còn lại:', timeLeft); // Log gỡ lỗi
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        countdownEl.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

        if (timeLeft <= 0) {
            clearInterval(timer);
            countdownEl.textContent = 'HẾT HẠN';
            countdownEl.style.color = '#dc3545';
            qrCodeEl.src = 'images/qr-momo2.jpg';
            qrCodeEl.classList.add('expired');
            confirmBtn.disabled = true;
            confirmBtn.textContent = 'Mã QR Đã Hết Hạn';
        }
        timeLeft--;
    }

    updateTimer();
    const timer = setInterval(updateTimer, 1000);
    window.addEventListener('beforeunload', () => clearInterval(timer));
})();