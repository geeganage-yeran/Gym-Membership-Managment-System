<%-- 
    Document   : processPayment
    Created on : Aug 9, 2024, 2:23:17 PM
    Author     : YERAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.classes.Payment" %>
<%@page import="app.classes.DbConnector" %>
<%
    int trainerId=Integer.parseInt(request.getParameter("trainerId"));
    int userId=Integer.parseInt(request.getParameter("userId"));
    String sessionTitle=request.getParameter("sessionTitle");
    
    Payment payment=new Payment(userId, trainerId, sessionTitle);
    if(payment.createPayment(DbConnector.getConnection())){
        response.sendRedirect("member.jsp?payment=101");
    }else{
        response.sendRedirect("member.jsp?payment=101");
    }
%>
