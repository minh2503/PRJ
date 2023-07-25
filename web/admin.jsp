<%-- 
    Document   : admin
    Created on : Mar 1, 2022, 8:29:12 PM
    Author     : hd
--%>

<%@page import="java.util.List"%>
<%@page import="pe.DTO.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>
        <h1>Hello User: <%= loginUser.getFullname()%> </h1>
        <form action="MainController">
            <input type="submit" value="Logout" name="Action" /> 
        </form>
        <form action="MainController">
            Search <input type="text" name="search" value="<%= search%>" />
            <input type="submit" value="Search" name="Action" />
        </form>
        <%
            List<UserDTO> list = (List<UserDTO>) request.getAttribute("LIST_USER");
            if (list != null) {
                if (!list.isEmpty()) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>userID</th>
                    <th>Fullname</th>
                    <th>RoleID</th>
                    <th>Status</th>
                    <th>Update</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (UserDTO user : list) {
                %>
            <form action="MainController">
                <tr>
                <td><%= count++ %></td>
                <td><%= user.getUserID() %></td>
                <td>
                    <input type="text" name="fullName" value="<%= user.getFullname() %>" />
                </td>
                <td>
                    <input type="text" name="chkRole" value="<%= user.getRoleID() %>" />
                </td>
                <td><%= user.isStatus()%></td>
                <td>
                    <input type="submit" value="Update" name="Action" />
                    <input type="hidden" name="userID" value="<%= user.getUserID()%> " />
                    <input type="hidden" name ="search" value="<%= search %>" />
                </td>
            </tr>
            </form>
            <%
                }
            %>     
        </tbody>
    </table>

    <%
            }
        }
    %>
</body>
</html>
