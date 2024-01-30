<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
</head>
<body>

<%
    String dbUrl = "jdbc:mysql://localhost:3306/vkdb";
    String dbUname = "root";
    String dbPassword = "";
    String dbDriver = "com.mysql.cj.jdbc.Driver";

    String userId = request.getParameter("id"); // Assume userId is obtained from the login session

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet resultSet = null;
    System.out.print((String)request.getParameter("id"));
    try {
        Class.forName(dbDriver);
        con = DriverManager.getConnection(dbUrl, dbUname, dbPassword);

        // Query to fetch user details based on the user ID
        String query = "SELECT * FROM student_table WHERE id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, userId);

        resultSet = pstmt.executeQuery();

        if (resultSet.next()) {
%>
            <h2>User Details</h2>
            <p>ID: <%= resultSet.getString("id") %></p>
            <p>Name: <%= resultSet.getString("name") %></p>
            <p>Password: <%= resultSet.getString("password") %></p>
            <p>Email: <%= resultSet.getString("email") %></p>
            <p>phone: <%= resultSet.getString("phone") %></p>
<%
        } else {
            // User not found
            out.println("<p>User not found</p>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
