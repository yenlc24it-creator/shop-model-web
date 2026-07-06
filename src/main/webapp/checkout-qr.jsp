<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán QR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-store"></i> Shop</a>
    </div>
</nav>

<div class="container my-4" style="max-width:550px;">
    <div class="card shadow">
        <div class="card-header bg-success text-white text-center">
            <h4 class="mb-0"><i class="fas fa-check-circle"></i> Đặt hàng thành công!</h4>
        </div>
        <div class="card-body">
            <div class="text-center mb-3">
                <h5>Mã đơn hàng: <span class="badge bg-primary">#${orderId}</span></h5>
                <p class="mb-1"><strong>Tổng tiền:</strong> ${total} VND</p>
                <div class="alert alert-warning">
                    <i class="fas fa-hand-holding-usd"></i> <strong>Số tiền cọc (20%):</strong> ${deposit} VND
                </div>
            </div>

            <div class="card bg-light mb-3">
                <div class="card-body">
                    <h6 class="card-title"><i class="fas fa-university"></i> Thông tin chuyển khoản</h6>
                    <table class="table table-sm table-borderless mb-0">
                        <tr>
                            <td><strong>Ngân hàng/Ví:</strong></td>
                            <td>${bankName}</td>
                        </tr>
                        <tr>
                            <td><strong>Chủ tài khoản:</strong></td>
                            <td>${accountHolder}</td>
                        </tr>
                        <tr>
                            <td><strong>Số tài khoản:</strong></td>
                            <td><span class="fw-bold text-primary">${accountNumber}</span></td>
                        </tr>
                        <tr>
                            <td><strong>Nội dung CK:</strong></td>
                            <td><code>${transferContent}</code></td>
                        </tr>
                        <tr>
                            <td><strong>Số tiền:</strong></td>
                            <td><span class="text-danger fw-bold">${deposit} VND</span></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="text-center">
                <p>Vui lòng quét mã QR để chuyển khoản cọc:</p>
                <img src="${qrImageUrl}" alt="Mã QR thanh toán" class="img-fluid rounded border qr-image"
                     style="max-width:220px;" onerror="this.src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFUOQwbC5EQNVtwuok2Ni1McPyt6VZyHSPLrfdinkqu10Zw-ILDqzFk7dZ&s=10'">
            </div>

            <p class="text-muted small text-center mt-3">
                <i class="fas fa-info-circle"></i> Sau khi chuyển khoản, admin sẽ xác nhận đơn hàng và cập nhật trạng thái.
            </p>
            <div class="d-flex justify-content-center gap-2 mt-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary"><i class="fas fa-home"></i> Về trang chủ</a>
                <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-secondary"><i class="fas fa-history"></i> Lịch sử đơn hàng</a>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-0">&copy; 2026 Shop. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>