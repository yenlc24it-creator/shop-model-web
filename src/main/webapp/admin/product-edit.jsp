<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container my-4" style="max-width:600px;">
    <div class="card shadow">
        <div class="card-header bg-warning text-white">
            <h4 class="mb-0"><i class="fas fa-edit"></i> Sửa sản phẩm</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/products/edit/${product.id}" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên sản phẩm</label>
                    <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Giá</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" value="${product.price}" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Tồn kho</label>
                    <input type="number" class="form-control" id="stock" name="stock" value="${product.stock}" required>
                </div>
                <div class="mb-3">
                    <label for="imageUrl" class="form-label">URL ảnh</label>
                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${product.imageUrl}">
                </div>
                <div class="mb-3">
                    <label for="categoryId" class="form-label">Danh mục</label>
                    <select class="form-select" id="categoryId" name="categoryId">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${cat.id == product.category.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-save"></i> Cập nhật</button>
            </form>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-link mt-2"><i class="fas fa-arrow-left"></i> Quay lại</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>