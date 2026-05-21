<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>5</title>
    <meta charset="UTF-8">
    <style>
        table { border-collapse: collapse; margin-top: 1rem; }
        th, td { border: 1px solid #333; padding: 0.4rem 0.8rem; text-align: center; }
        th { background: #eee; }
    </style>
</head>
<body>
<p><a href="index.jsp">Back</a></p>
<table>
    <thead>
    <tr>
        <th>i</th>
        <th>5 &times; i</th>
        <th>Result</th>
    </tr>
    </thead>
    <tbody>
    <%
        final int base = 5;
        for (int i = 1; i <= 10; i++) {
            int result = base * i;
    %>
    <tr>
        <td><%= i %></td>
        <td><%= base %> &times; <%= i %></td>
        <td><%= result %></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
