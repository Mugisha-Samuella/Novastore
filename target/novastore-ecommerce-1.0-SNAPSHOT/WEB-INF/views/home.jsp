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
    <title><fmt:message key="app.title" /></title>
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
                        <a class="nav-link active" href="home"><fmt:message key="nav.home" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="products"><fmt:message key="nav.products" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart">
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

    <!-- Hero Section -->
    <div class="bg-primary text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="display-4"><fmt:message key="app.welcome" /></h1>
                    <p class="lead">Discover our amazing products at great prices!</p>
                    <a href="products" class="btn btn-light btn-lg">
                        <fmt:message key="nav.products" />
                    </a>
                </div>
                <div class="col-md-6">
                    <!-- You can add an image here -->
                </div>
            </div>
        </div>
    </div>

    <!-- Featured Products -->
    <div class="container my-5">
        <h2 class="mb-4">Featured Products</h2>
        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach items="${featuredProducts}" var="product" begin="0" end="7">
                <div class="col">
                    <div class="card h-100">
                        <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text text-truncate">${product.description}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="h5 mb-0">$${product.price}</span>
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 0}">
                                        <button class="btn btn-primary btn-sm" onclick="addToCart(${product.id})">
                                            <fmt:message key="product.addToCart" />
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">
                                            <fmt:message key="product.outOfStock" />
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            fetch('add-to-cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=1'
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    location.reload();
                } else {
                    alert('Error adding product to cart');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding product to cart');
            });
        }
    </script>
</body>
</html> 