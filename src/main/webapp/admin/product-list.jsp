<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-md-block bg-dark sidebar" style="min-height:100vh;">
            <div class="position-sticky pt-3">
                <h4 class="text-white text-center py-3"><i class="fas fa-store"></i> Admin</h4>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-box"></i> Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-truck"></i> Đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </nav>

        <main class="col-md-10 ms-sm-auto px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Quản lý sản phẩm</h1>
                <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th>Danh mục</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <td>${p.price} VND</td>
                            <td>${p.stock}</td>
                            <td>${p.category.name}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/products/edit/${p.id}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/products/delete/${p.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa sản phẩm này?')"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>