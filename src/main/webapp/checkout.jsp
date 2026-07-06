<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
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

<div class="container my-4" style="max-width:600px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="fas fa-check-circle"></i> Xác nhận đơn hàng</h4>
        </div>
        <div class="card-body">
            <p><strong>Tổng tiền:</strong> <span class="text-danger">${total} VND</span></p>
            <div class="alert alert-warning">
                <i class="fas fa-info-circle"></i> <strong>Lưu ý:</strong> Bạn cần thanh toán <strong>20% cọc</strong> (${total * 0.2} VND) qua mã QR để đặt hàng.
            </div>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/checkout" method="post">
                <div class="mb-3">
                    <label for="shippingAddress" class="form-label">Địa chỉ nhận hàng</label>
                    <input type="text" class="form-control" id="shippingAddress" name="shippingAddress"
                           value="${userAddress}" required placeholder="Nhập địa chỉ của bạn">
                </div>
                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-check"></i> Xác nhận đặt hàng</button>
            </form>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-link mt-2"><i class="fas fa-arrow-left"></i> Quay lại giỏ hàng</a>
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