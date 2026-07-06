    <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ - Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-store"></i> Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products">Quản trị</a></li>
                    </c:if>
                </ul>
                <form class="d-flex me-2" action="" method="get">
                    <input class="form-control me-1" type="search" name="keyword" placeholder="Tìm sản phẩm..." value="${param.keyword}">
                    <select name="categoryId" class="form-select me-1" style="width:auto;">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${cat.id == param.categoryId ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                    <button class="btn btn-outline-primary" type="submit"><i class="fas fa-search"></i></button>
                </form>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i> Giỏ hàng
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-id-card"></i> Hồ sơ</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/history"><i class="fas fa-history"></i> Lịch sử đơn hàng</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <c:if test="${param.error == 'stock'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> Số lượng sản phẩm trong giỏ vượt quá tồn kho. Vui lòng kiểm tra lại!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <h2 class="text-center mb-4">Danh sách sản phẩm</h2>
        <c:choose>
            <c:when test="${empty products}">
                <div class="alert alert-info text-center">Không có sản phẩm nào.</div>
            </c:when>
            <c:otherwise>
                <!-- Grid hiển thị 4 cột trên màn hình lớn, 3 cột trên tablet, 2 cột trên mobile -->
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                    <c:forEach var="p" items="${products}">
                        <div class="col">
                            <div class="card product-card h-100">
                                <img src="${p.imageUrl}" class="card-img-top" alt="${p.name}"
                                     style="width:100%; height:220px; object-fit:cover; object-position:center; background:#f0f0f0;"
                                     onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'; this.style.height='220px';">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title"><a href="${pageContext.request.contextPath}/detail?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a></h5>
                                    <p class="price">${p.price} VND</p>
                                    <p class="text-muted small">Tồn kho: ${p.stock}</p>
                                    <p class="text-muted small">Danh mục: ${p.category.name}</p>
                                    <form action="${pageContext.request.contextPath}/cart/add" method="get" class="mt-auto">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <div class="input-group input-group-sm">
                                            <input type="number" name="quantity" value="1" min="1" max="${p.stock}" class="form-control" style="width:60px;">
                                            <button class="btn btn-primary" type="submit"><i class="fas fa-cart-plus"></i> Thêm</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item"><a class="page-link" href="?page=${currentPage-1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Trước</a></li>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item"><a class="page-link" href="?page=${currentPage+1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Sau</a></li>
                        </c:if>
                    </ul>
                </nav>
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