<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : 'en'}" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.messages" />

<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="cart.title" /> - <fmt:message key="app.title" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="home"><fmt:message key="app.title" /></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home"><fmt:message key="nav.home" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="products"><fmt:message key="nav.products" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="cart">
                            <fmt:message key="nav.cart" />
                            <c:if test="${not empty sessionScope.cart and sessionScope.cart.itemCount > 0}">
                                <span class="badge bg-light text-primary">${sessionScope.cart.itemCount}</span>
                            </c:if>
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div class="btn-group me-3">
                        <a href="?lang=en" class="btn btn-sm ${language == 'en' ? 'btn-light' : 'btn-outline-light'}">English</a>
                        <a href="?lang=es" class="btn btn-sm ${language == 'es' ? 'btn-light' : 'btn-outline-light'}">Español</a>
                        <a href="?lang=fr" class="btn btn-sm ${language == 'fr' ? 'btn-light' : 'btn-outline-light'}">Français</a>
                    </div>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="login" class="btn btn-outline-light"><fmt:message key="nav.login" /></a>
                        </c:when>
                        <c:otherwise>
                            <a href="profile" class="btn btn-outline-light me-2"><fmt:message key="nav.profile" /></a>
                            <a href="logout" class="btn btn-outline-light"><fmt:message key="nav.logout" /></a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><fmt:message key="cart.title" /></h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty sessionScope.cart or sessionScope.cart.empty}">
                                <div class="text-center py-5">
                                    <h4><fmt:message key="cart.empty" /></h4>
                                    <a href="products" class="btn btn-primary mt-3">
                                        <fmt:message key="nav.products" />
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th><fmt:message key="product.price" /></th>
                                                <th><fmt:message key="product.quantity" /></th>
                                                <th>Subtotal</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${sessionScope.cart.items}" var="item">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${item.product.imageUrl}" alt="${item.product.name}" 
                                                                 style="width: 50px; height: 50px; object-fit: cover;" 
                                                                 class="me-3">
                                                            <span>${item.product.name}</span>
                                                        </div>
                                                    </td>
                                                    <td>$${item.product.price}</td>
                                                    <td>
                                                        <form action="cart" method="post" class="d-flex align-items-center">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="productId" value="${item.product.id}">
                                                            <input type="number" name="quantity" value="${item.quantity}" 
                                                                   min="1" max="${item.product.stockQuantity}" 
                                                                   class="form-control form-control-sm" style="width: 70px">
                                                            <button type="submit" class="btn btn-sm btn-outline-primary ms-2">
                                                                <fmt:message key="cart.update" />
                                                            </button>
                                                        </form>
                                                    </td>
                                                    <td>$${item.subtotal}</td>
                                                    <td>
                                                        <form action="cart" method="post" class="d-inline">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="productId" value="${item.product.id}">
                                                            <button type="submit" class="btn btn-sm btn-danger">
                                                                <fmt:message key="cart.remove" />
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3" class="text-end">
                                                    <strong><fmt:message key="cart.total" />:</strong>
                                                </td>
                                                <td>
                                                    <strong>$${sessionScope.cart.total}</strong>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <div class="d-flex justify-content-between mt-4">
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="clear">
                                        <button type="submit" class="btn btn-outline-danger">
                                            Clear Cart
                                        </button>
                                    </form>
                                    <a href="checkout" class="btn btn-primary">
                                        <fmt:message key="cart.checkout" />
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 