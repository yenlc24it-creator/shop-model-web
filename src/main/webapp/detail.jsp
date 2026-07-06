<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
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

<div class="container my-4">
    <c:if test="${param.error == 'stock'}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> Số lượng sản phẩm trong giỏ vượt quá tồn kho. Vui lòng kiểm tra lại!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <div class="row">
        <div class="col-md-6">
            <img src="${product.imageUrl}" class="img-fluid rounded detail-img" alt="${product.name}" onerror="this.src='https://via.placeholder.com/500x400?text=No+Image'">
        </div>
        <div class="col-md-6">
            <h1>${product.name}</h1>
            <p class="h3 text-danger">${product.price} VND</p>
            <p><strong>Danh mục:</strong> ${product.category.name}</p>
            <p><strong>Tồn kho:</strong> ${product.stock}</p>
            <p class="mt-3">${product.description}</p>
            <form action="${pageContext.request.contextPath}/cart/add" method="get" class="mt-4">
                <input type="hidden" name="id" value="${product.id}">
                <div class="row g-2 align-items-center">
                    <div class="col-auto">
                        <label for="quantity" class="col-form-label">Số lượng:</label>
                    </div>
                    <div class="col-auto">
                        <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.stock}" class="form-control" style="width:80px;">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-cart-plus"></i> Thêm vào giỏ</button>
                    </div>
                </div>
            </form>
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary mt-3"><i class="fas fa-arrow-left"></i> Quay lại</a>
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