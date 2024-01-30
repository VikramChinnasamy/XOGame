
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Data</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }

        /* Optional: Add hover effect for better interactivity */
        table tr:hover {
            background-color: #ddd;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">

<%
    String dbUrl = "jdbc:mysql://localhost:3306/vkdb";
    String dbUname = "root";
    String dbPassword = "";
    String dbDriver = "com.mysql.cj.jdbc.Driver";
    Connection con = null;

    try {
        Class.forName(dbDriver);
        con = DriverManager.getConnection(dbUrl, dbUname, dbPassword);
        String sql = "SELECT * FROM matches";
        Statement s = con.createStatement();
        ResultSet resultSet = s.executeQuery(sql);

%>
        <table>
            <tr>
                <th>Total</th>
                <th>Score X</th>
                <th>Score O</th>
                <th>Losses X</th>
                <th>Losses O</th>
                <th>Draws X</th>
                <th>Draws O</th>
            </tr>
<%
        while (resultSet.next()) {
%>
            <tr>
                <td><%= resultSet.getInt("total") %></td>
                <td><%= resultSet.getInt("winX") %></td>
                <td><%= resultSet.getInt("winY") %></td>
                <td><%= resultSet.getInt("lossX") %></td>
                <td><%= resultSet.getInt("lossY") %></td>
                <td><%= resultSet.getInt("drawX") %></td>
                <td><%= resultSet.getInt("drawY") %></td>
            </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
        </table>
</div>

</body>
</html>
