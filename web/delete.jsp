<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int memberId = Integer.parseInt(request.getParameter("memberId"));
    User user = new User();
    if (user.deleteUser(DbConnector.getConnection(), memberId)) {
        response.sendRedirect("admin.jsp?id=1");
    } else {
        response.sendRedirect("admin.jsp?id=2");
    }
%>
