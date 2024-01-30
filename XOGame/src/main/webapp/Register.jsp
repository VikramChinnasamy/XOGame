<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('https://i.ytimg.com/vi/w6bCNW9aLd0/maxresdefault.jpg');
            background-size:cover;
           	
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            overflow: hidden;
        }

        form {
            background-color: f1f1f1;
            padding: 40px;
            border-radius: 8px;
            box-shadow: none;
            width: 400px;
            text-align: center;
            max-width: 80%;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin: 10px 0 8px;
            color: violet;
            font-size: 16px;
            font-size: large;
            font-weight: 10pc;
            font-style: bold;
            
            
        }

        input {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: none;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 14px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            text-decoration: none;
            color: #007bff;
            margin-left: 10px;
            font-size: 16px;
        }

        p {
            font-size: 16px;
            margin-top: 20px;
            color: #333;
        }

        /* Responsive styles */
        @media screen and (max-width: 600px) {
            form {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <form method="post" action="DemoServlet">
        <h2>Registration Form</h2>
        <label for="idc">ID No:</label>
        <input type="text" id="idc" name="idc" required>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" required>
        <button type="submit">Submit</button>
        <p>Already have an account? <a href="Login.html">Login</a></p>
    </form>

    <%-- Check for the registrationSuccess attribute and display an alert if true --%>
    <script>
        var registrationSuccess = '<%= request.getAttribute("registrationSuccess") %>';
        if (registrationSuccess === 'true') {
            alert('Registration successful!');
        }
    </script>
</body>
</html>
