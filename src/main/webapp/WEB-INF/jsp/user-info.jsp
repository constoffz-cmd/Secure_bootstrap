<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Form input</title>
    <style>
        a {
            background-color: lightgreen;
            color: black;
            padding: 0.1em 1em;
            text-decoration: none;
            text-transform: uppercase;
        }

        table {
            border-collapse: collapse;
            width: 50%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th { background-color: #f2f2f2; }
        .text-field {
            margin-bottom: 1rem;
        }
        text {
            display: block;
            margin-bottom: 0.25rem;
        }
        input {
            display: block;
            width: 100%;
            height: calc(2.25rem + 2px);
            padding: 0.375rem 0.75rem;
            font-family: inherit;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #bdbdbd;
            border-radius: 0.25rem;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

    </style>
</head>

<body>
<h2 th:text="${user.getId() == null} ? 'Add User' : 'Edit User'"></h2>
<form th:action="@{/save}" th:object="${user}" method="post">
    <input type="hidden" th:field="*{id}"/>

    Name: <input type="text" th:field="*{firstName}"/><br/><br/>
    Last Name: <input type="text" th:field="*{lastName}"/><br/><br/>
    Email: <input type="text" th:field="*{email}"/><br/><br/>

    <input type="submit" value="Save"/>
</form>
<br/>
<a th:href="@{/}">Back to list</a>
</body>
</html>