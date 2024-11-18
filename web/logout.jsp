<%-- 
    Document   : logout
    Created on : Aug 7, 2024, 7:45:54 PM
    Author     : YERAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>