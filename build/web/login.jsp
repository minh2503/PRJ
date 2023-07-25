<%-- 
    Document   : login
    Created on : Mar 11, 2022, 9:02:11 PM
    Author     : Minh
--%>

<%@page import="pe.DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <!--your code here-->
        <form action="MainController" method="POST">
            userID <input type="text" name="userID" value="" /><br>
            password <input type="password" name="password" value="" /><br>
            <input type="submit" value="Login" name="Action" />
            <input type="submit" value="Reset" />          
        </form>
        <%
            String loginUser = (String) session.getAttribute("ERROR_MESSAGE");
            if (loginUser == null) {
                loginUser = "";
            }
        %>
        <%= loginUser%>
    </body>

</html>

