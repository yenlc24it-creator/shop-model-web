<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>
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
    <h2><i class="fas fa-shopping-cart"></i> Giỏ hàng</h2>
    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="alert alert-info">Giỏ hàng trống. <a href="${pageContext.request.contextPath}/">Tiếp tục mua sắm</a></div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered table-hover cart-table">
                    <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="entry" items="${cartItems}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${entry.key.imageUrl}" alt="${entry.key.name}" class="cart-thumbnail me-2" onerror="this.src='https://via.placeholder.com/60x60?text=No+Image'">
                                    <span>${entry.key.name}</span>
                                </div>
                            </td>
                            <td>${entry.key.price} VND</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart/update" method="get" class="d-flex align-items-center">
                                    <input type="hidden" name="id" value="${entry.key.id}">
                                    <input type="number" name="quantity" value="${entry.value}" min="0" max="${entry.key.stock}" class="form-control quantity-input me-1">
                                    <button type="submit" class="btn btn-sm btn-outline-primary"><i class="fas fa-sync-alt"></i></button>
                                </form>
                            </td>
                            <td>${entry.key.price * entry.value} VND</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart/remove/${entry.key.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa sản phẩm này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">Tổng cộng:</th>
                        <th>${total} VND</th>
                        <th></th>
                    </tr>
                    </tfoot>
                </table>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-outline-danger" onclick="return confirm('Xóa toàn bộ giỏ hàng?')"><i class="fas fa-trash-alt"></i> Xóa toàn bộ</a>
                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success"><i class="fas fa-credit-card"></i> Thanh toán</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary"><i class="fas fa-arrow-left"></i> Tiếp tục mua sắm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-0">&copy; 2026 Shop. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>