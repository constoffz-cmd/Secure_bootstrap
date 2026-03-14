<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar { height: 100vh; background-color: white; padding-top: 20px; }
        .nav-pills .nav-link { border-radius: 0.25rem; }
        .nav-pills .nav-link.active { background-color: #0d6efd; }
        .control-label { font-weight: bold; margin-top: 10px; display: block; text-align: center; }
    </style>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-dark sticky-top shadow p-0">
    <div class="container-fluid px-3 py-2">
        <span class="navbar-brand">
            <!-- Имя пользователя -->
            <strong class="text-white"><sec:authentication property="name"/></strong>

            <span class="text-white">with roles:</span>

            <!-- Красивый вывод ролей через цикл -->
            <span class="text-white">
                <sec:authorize access="isAuthenticated()">
                    <c:forEach var="authority" items="${pageContext.request.userPrincipal.authorities}">
                        <span>${authority.authority.replace('ROLE_', '')}</span>
                    </c:forEach>
                </sec:authorize>
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
        <!-- ЛЕВАЯ ПАНЕЛЬ (ВЕРТИКАЛЬНЫЕ ВКЛАДКИ) -->
        <nav class="col-md-2 d-none d-md-block sidebar px-0 shadow-sm">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist">
                <button class="nav-link active text-start px-4" id="v-pills-admin-tab" data-bs-toggle="pill" data-bs-target="#v-pills-admin" type="button" role="tab">Admin</button>
                <button class="nav-link text-start px-4" id="v-pills-user-tab" data-bs-toggle="pill" data-bs-target="#v-pills-user" type="button" role="tab">User</button>
            </div>
        </nav>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <main class="col-md-10 ms-sm-auto px-md-4">

            <div class="tab-content" id="v-pills-tabContent">

                <!-- РАЗДЕЛ ADMIN -->
                <div class="tab-pane fade show active" id="v-pills-admin" role="tabpanel">
                    <div class="pt-3 pb-2 mb-3"><h1>Admin panel</h1></div>


                    <!-- Горизонтальные вкладки внутри Админа -->
                    <ul class="nav nav-tabs" id="adminTab" role="tablist">
                        <li class="nav-item">
                            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#users-table" type="button">Users table</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#new-user" type="button">New User</button>
                        </li>
                    </ul>

                    <div class="tab-content border border-top-0 bg-white">
                        <!-- ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ -->
                        <div class="tab-pane fade show active" id="users-table" role="tabpanel">
                            <div class="p-3 bg-light border-bottom"><h5 class="m-0">All users</h5></div>
                            <div class="p-3">
                                <table class="table table-striped table-hover align-middle">
                                    <thead>
                                    <tr>
                                        <th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Role</th><th>Edit</th><th>Delete</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${users}" var="user">
                                        <tr>
                                            <td>${user.id}</td><td>${user.firstName}</td><td>${user.lastName}</td><td>${user.email}</td>
                                            <td><c:forEach items="${user.roles}" var="r">${r.name.replace('ROLE_', '')} </c:forEach></td>
                                            <td><button class="btn btn-info btn-sm text-white" data-bs-toggle="modal" data-bs-target="#editModal${user.id}">Edit</button></td>
                                            <td><button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal${user.id}">Delete</button></td>
                                        </tr>
                                        <!-- МОДАЛКИ EDIT И DELETE ОСТАЮТСЯ ТУТ (внутри цикла) -->
                                        <div class="modal fade" id="editModal${user.id}" tabindex="-1" aria-hidden="true">


                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <form action="/admin/save" method="post">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Edit user</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body col-md-8 mx-auto text-center">
                                                            <input type="hidden" name="id" value="${user.id}">
                                                            <input type="hidden" name="username" value="${user.username}">

                                                            <label class="control-label">ID</label>
                                                            <input type="text" class="form-control bg-light" value="${user.id}" readonly>

                                                            <label class="control-label">First name</label>
                                                            <input type="text" name="firstName" class="form-control" value="${user.firstName}">

                                                            <label class="control-label">Last name</label>
                                                            <input type="text" name="lastName" class="form-control" value="${user.lastName}">
                                                            <label class="control-label">Email</label>
                                                            <input type="email" name="email" class="form-control" value="${user.email}" required>

                                                            <label class="control-label">Password</label>
                                                            <input type="password" name="password" class="form-control">

                                                            <label class="control-label">Role</label>
                                                            <select name="selectedRoles" class="form-select" multiple size="2">
                                                                <c:forEach items="${allRoles}" var="role">
                                                                    <option value="${role.id}"
                                                                            <c:forEach items="${user.roles}" var="userRole">
                                                                                <c:if test="${userRole.id == role.id}">selected</c:if>
                                                                            </c:forEach>
                                                                    >${role.name.replace('ROLE_', '')}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-primary">Edit</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- MODAL DELETE (PREVIEW) -->
                                        <div class="modal fade" id="deleteModal${user.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <form action="/admin/delete" method="post">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Delete user</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body col-md-8 mx-auto text-center">
                                                            <label class="control-label">ID</label>
                                                            <input type="text" name="id" class="form-control bg-light" value="${user.id}" readonly>

                                                            <label class="control-label">First name</label>
                                                            <input type="text" class="form-control bg-light" value="${user.firstName}" readonly>

                                                            <label class="control-label">Last name</label>
                                                            <input type="text" class="form-control bg-light" value="${user.lastName}" readonly>

                                                            <label class="control-label">Email</label>
                                                            <input type="email" class="form-control bg-light" value="${user.email}" readonly>

                                                            <label class="control-label">Role</label>
                                                            <select class="form-select bg-light" multiple size="2" disabled>
                                                                <c:forEach items="${user.roles}" var="userRole">
                                                                    <option>${userRole.name.replace('ROLE_', '')}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- ВКЛАДКА NEW USER -->
                        <div class="tab-pane fade" id="new-user" role="tabpanel">
                            <div class="p-3 bg-light border-bottom"><h5 class="m-0">Add new user</h5></div>
                            <div class="p-4 row justify-content-center">
                                <div class="col-md-4 text-center">
                                    <form action="/admin/save" method="post">
                                        <label class="control-label">First name</label>
                                        <input type="text" name="firstName" class="form-control mb-3">
                                        <label class="control-label">Last name</label>
                                        <input type="text" name="lastName" class="form-control mb-3">
                                        <label class="control-label">Email</label>
                                        <input type="email" name="email" class="form-control mb-3" required>
                                        <label class="control-label">Username</label>
                                        <input type="text" name="username" class="form-control mb-3" required>
                                        <label class="control-label">Password</label>
                                        <input type="password" name="password" class="form-control mb-3" required>
                                        <label class="control-label">Role</label>
                                        <select name="selectedRoles" class="form-select mb-3" multiple size="2">
                                            <c:forEach items="${allRoles}" var="role">
                                                <option value="${role.id}">${role.name.replace('ROLE_', '')}</option>
                                            </c:forEach>
                                        </select>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-success btn-lg px-4 mt-2">Add new user</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- РАЗДЕЛ USER (ИНФОРМАЦИЯ О СЕБЕ) -->
                <div class="tab-pane fade" id="v-pills-user" role="tabpanel">
                    <div class="pt-3 pb-2 mb-3"><h1>User information page</h1></div>
                    <div class="card shadow-sm">
                        <div class="card-header bg-light"><h5 class="m-0">About user</h5></div>
                        <div class="card-body">
                            <table class="table table-striped align-middle">
                                <thead>
                                <tr>
                                    <th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Role</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>${currentUser.id}</td>
                                    <td>${currentUser.firstName}</td>
                                    <td>${currentUser.lastName}</td>
                                    <td>${currentUser.email}</td>
                                    <td>
                                        <c:forEach items="${currentUser.roles}" var="r">
                                            ${r.name.replace('ROLE_', '')}
                                        </c:forEach>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
