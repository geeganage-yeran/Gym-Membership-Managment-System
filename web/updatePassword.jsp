<%-- 
    Document   : updatePassword
    Created on : Aug 8, 2024, 10:38:54 PM
    Author     : YERAN
--%>

<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern"%>

<%
    String oldPwd = request.getParameter("oldPwd");
    String newPwd = request.getParameter("newPwd");
    String confirmPwd = request.getParameter("confirmPwd");

 
    boolean isValid = true;

    if (oldPwd == null || oldPwd.trim().isEmpty()) {
        isValid = false;
    }
    if (newPwd == null || newPwd.trim().isEmpty()) {
        isValid = false;
    }
    if (confirmPwd == null || confirmPwd.trim().isEmpty()) {
        isValid = false;
    }

    if (isValid) {
        User user = new User();
        int id = (Integer) session.getAttribute("id");
        user.setId(id);
        user.setPassword(oldPwd);

        if (user.updatePassword(DbConnector.getConnection(), newPwd)) {
            response.sendRedirect("member.jsp?pUpdate=104");
        } else {
            response.sendRedirect("member.jsp?pUpdate=105");
        }
    } else {
        response.sendRedirect("member.jsp?pUpdate=106");
    }
%>
