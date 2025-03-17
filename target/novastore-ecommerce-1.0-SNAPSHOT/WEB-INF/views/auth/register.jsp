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
      <fmt:message key="register.title" /> - <fmt:message key="app.title" />
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
        <div class="col-md-8">
          <div class="card shadow">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0"><fmt:message key="register.title" /></h3>
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
                  <fmt:message key="${error}" />
                </div>
              </c:if>

              <form
                action="register"
                method="post"
                onsubmit="return validateForm()"
              >
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="firstName" class="form-label"
                      ><fmt:message key="register.firstName"
                    /></label>
                    <input
                      type="text"
                      class="form-control"
                      id="firstName"
                      name="firstName"
                      required
                    />
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="lastName" class="form-label"
                      ><fmt:message key="register.lastName"
                    /></label>
                    <input
                      type="text"
                      class="form-control"
                      id="lastName"
                      name="lastName"
                      required
                    />
                  </div>
                </div>
                <div class="mb-3">
                  <label for="email" class="form-label"
                    ><fmt:message key="register.email"
                  /></label>
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    required
                  />
                </div>
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="password" class="form-label"
                      ><fmt:message key="register.password"
                    /></label>
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      name="password"
                      required
                    />
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="confirmPassword" class="form-label"
                      ><fmt:message key="register.confirmPassword"
                    /></label>
                    <input
                      type="password"
                      class="form-control"
                      id="confirmPassword"
                      name="confirmPassword"
                      required
                    />
                  </div>
                </div>
                <div class="mb-3">
                  <label for="address" class="form-label"
                    ><fmt:message key="register.address"
                  /></label>
                  <textarea
                    class="form-control"
                    id="address"
                    name="address"
                    rows="2"
                    required
                  ></textarea>
                </div>
                <div class="mb-3">
                  <label for="phoneNumber" class="form-label"
                    ><fmt:message key="register.phoneNumber"
                  /></label>
                  <input
                    type="tel"
                    class="form-control"
                    id="phoneNumber"
                    name="phoneNumber"
                    required
                  />
                </div>
                <div class="d-grid gap-2">
                  <button type="submit" class="btn btn-primary">
                    <fmt:message key="register.submit" />
                  </button>
                </div>
              </form>

              <div class="mt-3 text-center">
                <a href="login" class="text-decoration-none">
                  <fmt:message key="register.login" />
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function validateForm() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
          alert('<fmt:message key="register.error.password" />');
          return false;
        }
        return true;
      }
    </script>
  </body>
</html>
