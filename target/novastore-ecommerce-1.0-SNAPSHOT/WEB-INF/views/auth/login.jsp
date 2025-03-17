<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set
  var="language"
  value="${not empty sessionScope.language ? sessionScope.language : 'en'}"
/>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.messages" />

<!DOCTYPE html>
<html lang="${language}">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
      <fmt:message key="login.title" /> - <fmt:message key="app.title" />
    </title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link href="css/style.css" rel="stylesheet" />
  </head>
  <body class="bg-light">
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card shadow">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0"><fmt:message key="login.title" /></h3>
            </div>
            <div class="card-body">
              <!-- Language Selection -->
              <div class="mb-3 text-end">
                <div class="btn-group">
                  <a
                    href="?lang=en"
                    class="btn btn-sm ${language == 'en' ? 'btn-primary' : 'btn-outline-primary'}"
                    >English</a
                  >
                  <a
                    href="?lang=es"
                    class="btn btn-sm ${language == 'es' ? 'btn-primary' : 'btn-outline-primary'}"
                    >Español</a
                  >
                  <a
                    href="?lang=fr"
                    class="btn btn-sm ${language == 'fr' ? 'btn-primary' : 'btn-outline-primary'}"
                    >Français</a
                  >
                </div>
              </div>

              <c:if test="${not empty error}">
                <div class="alert alert-danger">
                  <fmt:message key="login.error" />
                </div>
              </c:if>

              <form action="login" method="post">
                <div class="mb-3">
                  <label for="email" class="form-label"
                    ><fmt:message key="login.email"
                  /></label>
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    required
                  />
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label"
                    ><fmt:message key="login.password"
                  /></label>
                  <input
                    type="password"
                    class="form-control"
                    id="password"
                    name="password"
                    required
                  />
                </div>
                <div class="d-grid gap-2">
                  <button type="submit" class="btn btn-primary">
                    <fmt:message key="login.submit" />
                  </button>
                </div>
              </form>

              <div class="mt-3 text-center">
                <a href="register" class="text-decoration-none">
                  <fmt:message key="login.register" />
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
