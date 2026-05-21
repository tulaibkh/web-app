<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <meta charset="UTF-8">
</head>
<body>
<p><a href="multiplication.jsp">Multiplication</a></p>
<form action="welcome.jsp" method="get">
    <label>Number <input type="number" name="number" required></label>
    <br><br>
    <label>
        Color
        <select name="color">
            <option value="red">Red</option>
            <option value="green">Green</option>
            <option value="blue">Blue</option>
        </select>
    </label>
    <br><br>
    <button type="submit">Submit</button>
</form>
</body>
</html>
