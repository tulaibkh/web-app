<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String raw = request.getParameter("number");
    String colorParam = request.getParameter("color");
    if (colorParam == null || colorParam.isBlank()) {
        colorParam = "white";
    } else {
        String c = colorParam.trim().toLowerCase();
        if ("red".equals(c) || "green".equals(c) || "blue".equals(c)) {
            colorParam = c;
        } else {
            colorParam = "white";
        }
    }
    String parityLabel = "unknown";
    Integer square = null;
    Integer n = null;
    String error = null;

    if (raw == null || raw.isBlank()) {
        error = "Missing number.";
    } else {
        try {
            n = Integer.parseInt(raw.trim());
            square = n * n;
            if (n % 2 == 0) {
                parityLabel = "Even";
            } else {
                parityLabel = "Odd";
            }
        } catch (NumberFormatException ex) {
            error = "Invalid number.";
        }
    }

    if (error == null && n != null && square != null) {
        String url = application.getInitParameter("mysql.jdbcUrl");
        String user = application.getInitParameter("mysql.user");
        String pass = application.getInitParameter("mysql.password");
        if (url != null && user != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(url, user, pass == null ? "" : pass);
                     PreparedStatement ps = conn.prepareStatement(
                             "INSERT INTO lab_logs (num_value, square_value, parity, color) VALUES (?,?,?,?)")) {
                    ps.setInt(1, n);
                    ps.setInt(2, square);
                    ps.setString(3, parityLabel);
                    ps.setString(4, colorParam);
                    ps.executeUpdate();
                }
            } catch (Exception ignored) {
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <meta charset="UTF-8">
</head>
<body style="background-color: <%= colorParam %>;">
<h1>Welcome</h1>

<% if (error != null) { %>
<p style="color: maroon;"><%= error %></p>
<p><a href="index.jsp">Back</a></p>
<% } else { %>
<p><strong><%= n %></strong></p>
<p><strong><%= square %></strong></p>
<p><strong><%= parityLabel %></strong></p>
<p><a href="index.jsp">Back</a></p>
<% } %>
</body>
</html>
