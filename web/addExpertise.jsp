<%-- 
    Document   : updateAvailability
    Created on : Aug 9, 2024, 3:36:57 PM
    Author     : YERAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%
    String expertise=request.getParameter("expertise");
    int trainerId=(Integer) session.getAttribute("id");
    
    User user=new User();
    user.setExpertise(expertise);
    user.setId(trainerId);
    if(user.addExpertise(DbConnector.getConnection())){
        session.setAttribute("expertise", user.getExpertise());
        response.sendRedirect("trainer.jsp?pUpdate=401");
    }else{
        response.sendRedirect("trainer.jsp?pUpdate=402");
    }
%>