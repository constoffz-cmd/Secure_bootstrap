<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <span class="navbar-brand">
            <strong><sec:authentication property="name"/></strong> with roles:
            <sec:authentication property="authorities"/>
        </span>
        <form action="/logout" method="post" class="m-0">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="btn btn-outline-light btn-sm" type="submit">Logout</button>
        </form>
    </div>
</nav>

<div class="container">
    <h2>User Management</h2>

    <!-- Кнопка вызова модалки для добавления нового пользователя -->
    <button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addNewUserModal">
        Add New User
    </button>

    <div class="card shadow">
        <div class="card-body">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Roles</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.email}</td>
                        <td>
                            <c:forEach items="${user.roles}" var="role">
                                <span class="badge bg-secondary">${role.name}</span>
                            </c:forEach>
                        </td>
                        <td>

                            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal${user.id}">
                                Edit
                            </button>

                            <!-- Кнопка DELETE -->
                            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal${user.id}">
                                Delete
                            </button>
                        </td>
                    </tr>

                    <!-- МОДАЛЬНОЕ ОКНО EDIT -->
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

                    <!-- МОДАЛЬНОЕ ОКНО DELETE -->
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
    </div>
</div>

<!-- МОДАЛЬНОЕ ОКНО ДЛЯ ADD NEW USER (вынесено за цикл) -->
<div class="modal fade" id="addNewUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/admin/save" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Add New User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label fw-bold">Username</label>
                    <input type="text" name="username" class="form-control mb-2" required>

                    <label class="form-label">First Name</label>
                    <input type="text" name="firstName" class="form-control mb-2">

                    <label class="form-label">Last Name</label>
                    <input type="text" name="lastName" class="form-control mb-2">

                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control mb-2" required>

                    <label class="form-label fw-bold">Password</label>
                    <input type="password" name="password" class="form-control mb-2" required>

                    <label class="form-label fw-bold">Roles</label>
                    <select name="selectedRoles" class="form-select" multiple size="2">
                        <c:forEach items="${allRoles}" var="role">
                            <option value="${role.id}">${role.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-success">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>