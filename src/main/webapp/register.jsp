<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script>
        function validateForm() {
            var fullName = document.getElementById("fullName").value;
            // Kiểm tra xem có dấu tiếng Việt (kiểm tra đơn giản)
            var hasVietnamese = /[àáảãạăắằẳẵặâấầẩẫậđèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵ]/.test(fullName);
            if (hasVietnamese) {
                alert("Vui lòng nhập tên không dấu (ví dụ: Nguyen Van A).");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container my-5" style="max-width:500px;">
    <div class="card shadow">
        <div class="card-header bg-success text-white text-center">
            <h4><i class="fas fa-user-plus"></i> Đăng ký tài khoản</h4>
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm()">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và tên</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Ví dụ: Nguyen Van A">
                    <small class="text-muted">Vui lòng nhập tên không dấu (không có dấu tiếng Việt).</small>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone">
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address">
                </div>
                <button type="submit" class="btn btn-success w-100">Đăng ký</button>
            </form>
            <p class="mt-3 text-center">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>