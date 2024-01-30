import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServletResponse;

public class CheckDatabase {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vkdb";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private String id;
    private String name;
    private String pass;
    private HttpServletResponse response;

    public CheckDatabase(String id, String name, String pass, HttpServletResponse response) {
        this.id = id;
        this.name = name;
        this.pass = pass;
        this.response = response;
    }

    public void check() {
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
                // Check if the given id, name, and password match with the data in the database (case-sensitive)
                String sql = "SELECT * FROM student_table WHERE BINARY id = ? AND BINARY name = ? AND BINARY password = ?";
                try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
                    preparedStatement.setString(1, id);
                    preparedStatement.setString(2, name);
                    preparedStatement.setString(3, pass);

                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                            // Redirect to another page with user details
                            response.sendRedirect("main.html");
                        } else {
                            // Id, name, and password do not match, show an alert message
                            try (PrintWriter out = response.getWriter()) {
                                out.println("<script type='text/javascript'>");
                                out.println("alert('Id, name, and password do not match.');");
                                out.println("window.location='Login.html';");
                                out.println("</script>");
                            }
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Log this exception
        } catch (SQLException | IOException e) {
            e.printStackTrace(); // Log this exception
        }
    }
}

