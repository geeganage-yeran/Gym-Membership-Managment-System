<%-- 
    Document   : changeStatus
    Created on : Aug 8, 2024, 4:28:30 PM
    Author     : YERAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.classes.User" %>
<%@page import="app.classes.DbConnector" %>
<%
    int memberId = Integer.parseInt(request.getParameter("userId"));
    String action = request.getParameter("action");
    User user = new User();
    if (action.equals("activate")) {
        if (user.activateUser(DbConnector.getConnection(), memberId)) {
            response.sendRedirect("admin.jsp?id=15");
        } else {
            response.sendRedirect("admin.jsp?id=16");
        }
    } else if(action.equals("deactivate")) {
        if (user.deactivateUser(DbConnector.getConnection(), memberId)) {
            response.sendRedirect("admin.jsp?id=17");
        } else {
            response.sendRedirect("admin.jsp?id=16");
        }
    }
%>
