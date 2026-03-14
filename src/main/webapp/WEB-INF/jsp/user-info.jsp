<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">${user.id == null ? "Add New User" : "Edit User"}</h4>
                </div>
                <div class="card-body">
                    <form action="/admin/save" method="post">
                        <input type="hidden" name="id" value="${user.id}">

                        <div class="mb-3">
                            <label class="form-label font-weight-bold">Username</label>
                            <input type="text" name="username" class="form-control" value="${user.username}" required>
                        </div>

                        <div class="row">
                            <div class="col mb-3">
                                <label class="form-label">First Name</label>
                                <input type="text" name="firstName" class="form-control" value="${user.firstName}">
                            </div>
                            <div class="col mb-3">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="lastName" class="form-control" value="${user.lastName}">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="${user.email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control"
                                   placeholder="${user.id == null ? 'Enter password' : 'Leave empty to keep current'}">
                        </div>


                        <div class="mb-3 p-3 border rounded bg-white">
                            <label class="form-label d-block">Roles</label>
                            <c:forEach items="${allRoles}" var="role">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="selectedRoles"
                                           value="${role.id}" id="role${role.id}"
                                    <c:forEach items="${user.roles}" var="userRole">
                                           <c:if test="${userRole.id == role.id}">checked</c:if>
                                    </c:forEach>
                                    >
                                    <label class="form-check-label" for="role${role.id}">
                                            ${role.name}
                                    </label>
                                </div>
                            </c:forEach>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">Save User</button>
                            <a href="/admin/users" class="btn btn-link text-secondary">Back to list</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>