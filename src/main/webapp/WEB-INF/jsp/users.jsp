<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Users</title>

    <style>
        a {
            background-color: lightgreen;
            color: black;
            padding: 0.1em 1em;
            text-decoration: none;
            text-transform: uppercase;
        }

        .table {
            border: 1px solid #eee;
            table-layout: fixed;
            width: 100%;
            margin-bottom: 20px;
        }
        .table th {
            font-weight: bold;
            padding: 5px;
            background: #efefef;
            border: 1px solid #dddddd;
        }
        .table td{
            padding: 5px 10px;
            border: 1px solid #eee;
            text-align: left;
        }
        .table tbody tr:nth-child(odd){
            background: #fff;
        }
        .table tbody tr:nth-child(even){
            background: #F7F7F7;
        }
    </style>
</head>
<body>
<h2>User Management</h2>
<table class="table" border="1">

    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Last Name</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    <tr th:each="user : ${userss}">
        <td th:text="${user.getId()}"></td>
        <td th:text="${user.getFirstName()}"></td>
        <td th:text="${user.getLastName()}"></td>
        <td th:text="${user.getEmail()}"></td>
        <td>
            <!-- Ссылка с параметром id -->
            <a th:href="@{/edit(id=${user.getId()})}">Edit</a>
            |
            <!-- Форма для удаления через POST -->
            <form th:action="@{/delete}" method="post" style="display:inline">
                <input type="hidden" name="id" th:value="${user.getId()}"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
</table>
<br/>
<a th:href="@{/add}">Add New User</a>
</body>
</html>