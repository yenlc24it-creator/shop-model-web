<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-box"></i> Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-truck"></i> Đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </nav>

        <main class="col-md-10 ms-sm-auto px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Quản lý đơn hàng</h1>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Người dùng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Địa chỉ</th>
                        <th>Phương thức</th>
                        <th>Trạng thái</th>
                        <th>Cập nhật</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#${o.id}</td>
                            <td>${o.user.username}</td>
                            <td>${o.orderDate}</td>
                            <td>${o.total} VND</td>
                            <td>${o.shippingAddress}</td>
                            <td>${o.paymentMethod}</td>
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
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex gap-1">
                                    <input type="hidden" name="orderId" value="${o.id}">
                                    <select name="status" class="form-select form-select-sm">
                                        <option value="PENDING" ${o.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                        <option value="PROCESSING" ${o.status == 'PROCESSING' ? 'selected' : ''}>PROCESSING</option>
                                        <option value="SHIPPED" ${o.status == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
                                        <option value="DELIVERED" ${o.status == 'DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                                        <option value="CANCELLED" ${o.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-sync-alt"></i></button>
                                </form>
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