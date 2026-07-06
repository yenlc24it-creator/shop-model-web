<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
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
    <h2><i class="fas fa-history"></i> Lịch sử đơn hàng</h2>
    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Phương thức</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#${o.id}</td>
                            <td>${o.orderDate}</td>
                            <td>${o.total} VND</td>
                            <td>
                                        <span class="badge
                                            ${o.status == 'PENDING' ? 'bg-warning' :
                                              o.status == 'PROCESSING' ? 'bg-info' :
                                              o.status == 'SHIPPED' ? 'bg-primary' :
                                              o.status == 'DELIVERED' ? 'bg-success' :
                                              'bg-danger'}">
                                                ${o.status}
                                        </span>
                            </td>
                            <td>${o.paymentMethod}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Trang chủ</a>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-0">&copy; 2026 Shop. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>