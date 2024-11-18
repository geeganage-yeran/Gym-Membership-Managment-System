<%-- 
    Document   : deleteSession
    Created on : Aug 9, 2024, 12:19:28 PM
    Author     : YERAN
--%>

<%@page import="java.sql.Date"%>
<%@page import="app.classes.DbConnector" %>
<%@page import="app.classes.Session" %>
<%@page import="app.classes.Payment" %>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Session newSession=new Session();
    Payment newPayment=new Payment();
    int sessionId =Integer.parseInt(request.getParameter("sessionId"));
    int trainerId =Integer.parseInt(request.getParameter("trainerId"));
    String title=request.getParameter("title");
    newSession.setId(sessionId);
    newPayment.setTrainerId(trainerId);
    newPayment.setSessionTitle(title);
    if(newSession.deleteSession(DbConnector.getConnection())){
        response.sendRedirect("trainer.jsp?class=201");
    }else{
        response.sendRedirect("trainer.jsp?class=202");
    }
    newPayment.deleteSubcribedDetails(DbConnector.getConnection());

%>