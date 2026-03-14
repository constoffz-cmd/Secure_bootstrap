> ChatGPT | Nano Banana:
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>User Page</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Стиль для боковой панели на всю высоту */
    .sidebar { height: 100vh; background-color: white; padding-top: 20px; }
    .nav-pills .nav-link { border-radius: 0.25rem; }
  </style>
</head>
<body class="bg-light">

<!-- ВЕРХНИЙ NAVBAR -->
<nav class="navbar navbar-dark bg-dark sticky-top shadow p-0">
  <div class="container-fluid px-3 py-2">
        <span class="navbar-brand">
            <!-- Имя текущего пользователя и его роли -->
            <strong><sec:authentication property="name"/></strong> 
            <span class="text-white">with roles:</span>
            <span class="text-white">
                <c:forEach var="authority" items="${pageContext.request.userPrincipal.authorities}">
                  <span>${authority.authority.replace('ROLE_', '')}</span>
                </c:forEach>
            </span>
        </span>
    <form action="/logout" method="post" class="m-0">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <button class="btn btn-outline-secondary text-light border-0" type="submit">Logout</button>
    </form>
  </div>
</nav>

<div class="container-fluid">
  <div class="row">
    <!-- ЛЕВАЯ ПАНЕЛЬ (SIDEBAR) -->
    <nav class="col-md-2 d-none d-md-block sidebar px-0 shadow-sm">
      <div class="nav flex-column nav-pills">
        <!-- Ссылка для Админа (показывается только админам) -->
        <sec:authorize access="hasRole('ADMIN')">
          <a class="nav-link px-4" href="/admin">Admin</a>
        </sec:authorize>
        <!-- Активная ссылка текущей страницы -->
        <a class="nav-link active px-4" href="/user">User</a>
      </div>
    </nav>

    <!-- ОСНОВНОЙ КОНТЕНТ -->
    <main class="col-md-10 ms-sm-auto px-md-4 bg-light">
      <div class="pt-3 pb-2 mb-3">
        <h1>User information page</h1>
      </div>

      <div class="card shadow-sm">
        <div class="card-header bg-light">
          <h5 class="m-0">About user</h5>
        </div>
        <div class="card-body">
          <!-- ТАБЛИЦА С ДАННЫМИ -->
          <table class="table table-striped table-hover align-middle">
            <thead>
            <tr>
              <th>ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Email</th>
              <th>Role</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>${currentUser.id}</td>
              <td>${currentUser.firstName}</td>
              <td>${currentUser.lastName}</td>
              <td>${currentUser.email}</td>
              <td>
                <c:forEach items="${currentUser.roles}" var="role">
                  <span>${role.name.replace('ROLE_', '')}</span>
                </c:forEach>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

