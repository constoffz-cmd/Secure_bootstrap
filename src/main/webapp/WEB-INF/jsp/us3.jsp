> ChatGPT | Nano Banana:
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
        /* Делаем боковую панель на весь экран */
        .sidebar { height: 100vh; background-color: white; padding-top: 20px; }
        .nav-pills .nav-link.active { border-radius: 0.25rem; }
    </style>
</head>
<body class="bg-light">

<!-- Верхний Navbar -->
<nav class="navbar navbar-dark bg-dark sticky-top shadow">
    <div class="container-fluid">
        <span class="navbar-brand">
            <strong><sec:authentication property="name"/></strong> with roles: 
            <span><sec:authentication property="authorities"/></span>
        </span>
        <form action="/logout" method="post" class="m-0">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="btn btn-outline-secondary btn-sm text-light border-0" type="submit">Logout</button>
        </form>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Левая панель навигации (Admin / User) -->
        <nav class="col-md-2 d-none d-md-block sidebar px-0">
            <div class="nav flex-column nav-pills" role="tablist">
                <a class="nav-link active" href="/admin">Admin</a>
                <a class="nav-link" href="/user">User</a>
            </div>
        </nav>

        <!-- Основной контент справа -->
        <main class="col-md-10 ms-sm-auto px-md-4 bg-light">
            <div class="pt-3 pb-2 mb-3 border-bottom">
                <h1>Admin panel</h1>
            </div>

            <!-- ВКЛАДКИ (TABS) -->
            <ul class="nav nav-tabs" id="adminTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="users-table-tab" data-bs-toggle="tab" data-bs-target="#users-table" type="button" role="tab">Users table</button>
                </li>
                <li class="nav-item" role="presentation">


                    <button class="nav-link" id="new-user-tab" data-bs-toggle="tab" data-bs-target="#new-user" type="button" role="tab">New User</button>
                </li>
            </ul>

            <!-- СОДЕРЖИМОЕ ВКЛАДОК -->
            <div class="tab-content border border-top-0 bg-white shadow-sm">

                <!-- ВКЛАДКА 1: ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ -->
                <div class="tab-pane fade show active p-3" id="users-table" role="tabpanel">
                    <h5 class="mb-3">All users</h5>
                    <table class="table table-striped table-hover align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.firstName}</td>
                                <td>${user.lastName}</td>
                                <td>${user.email}</td>
                                <td>
                                    <c:forEach items="${user.roles}" var="role">
                                        ${role.name}
                                    </c:forEach>
                                </td>
                                <td>
                                    <button class="btn btn-info btn-sm text-white" data-bs-toggle="modal" data-bs-target="#editModal${user.id}">Edit</button>
                                </td>
                                <td>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal${user.id}">Delete</button>
                                </td>
                            </tr>

                            <!-- ЗДЕСЬ ОСТАЮТСЯ ВАШИ МОДАЛКИ EDIT И DELETE (из предыдущего ответа) -->
                            <div class="modal fade" id="editModal${user.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="/admin/save" method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit User: ${user.username}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-center">
                                                <input type="hidden" name="id" value="${user.id}">

                                                <label class="form-label fw-bold">Username</label>
                                                <input type="text" name="username" class="form-control mb-2" value="${user.username}" required>

                                                <label class="form-label fw-bold">First Name</label>
                                                <input type="text" name="firstName" class="form-control mb-2" value="${user.firstName}">

                                                <label class="form-label fw-bold">Last Name</label>
                                                <input type="text" name="lastName" class="form-control mb-2" value="${user.lastName}">

                                                <label class="form-label fw-bold">Email</label>
                                                <input type="email" name="email" class="form-control mb-2" value="${user.email}" required>


                                                <label class="form-label fw-bold">Password</label>
                                                <input type="password" name="password" class="form-control mb-2">

                                                <label class="form-label fw-bold">Roles</label>
                                                <select name="selectedRoles" class="form-select" multiple size="2">
                                                    <c:forEach items="${allRoles}" var="role">
                                                        <option value="${role.id}"
                                                                <c:forEach items="${user.roles}" var="userRole">
                                                                    <c:if test="${userRole.id == role.id}">selected</c:if>
                                                                </c:forEach>
                                                        >${role.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="deleteModal${user.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="/admin/delete" method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Delete User</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-center">
                                                <p>Are you sure you want to delete user <strong>${user.username}</strong>?</p>
                                                <input type="hidden" name="id" value="${user.id}">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
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

                <!-- ВКЛАДКА 2: ФОРМА НОВОГО ПОЛЬЗОВАТЕЛЯ -->
                <div class="tab-pane fade p-3" id="new-user" role="tabpanel">
                    <h5 class="mb-3">Add new user</h5>
                    <div class="row justify-content-center">
                        <div class="col-md-4 text-center fw-bold">
                            <form action="/admin/save" method="post">
                                <label class="form-label">First name</label>
                                <input type="text" name="firstName" class="form-control mb-3">

                                <label class="form-label">Last name</label>
                                <input type="text" name="lastName" class="form-control mb-3">

                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control mb-3" required>

                                <label class="form-label">Username (Login)</label>
                                <input type="text" name="username" class="form-control mb-3" required>

                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control mb-3" required>

                                <label class="form-label">Role</label>
                                <select name="selectedRoles" class="form-select mb-3" multiple size="2">
                                    <c:forEach items="${allRoles}" var="role">
                                        <option value="${role.id}">${role.name}</option>
                                    </c:forEach>
                                </select>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-success btn-lg px-4">Add new user</button>
                            </form>
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
