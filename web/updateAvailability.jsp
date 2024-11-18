<%-- 
    Document   : updateAvailability
    Created on : Aug 9, 2024, 3:36:57 PM
    Author     : YERAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%
    String availability=request.getParameter("availability");
    int trainerId=(Integer) session.getAttribute("id");
    
    User user=new User();
    user.setAvailability(availability);
    user.setId(trainerId);
    if(user.updateAvailability(DbConnector.getConnection())){
        session.setAttribute("availability", user.getAvailability());
        response.sendRedirect("trainer.jsp?pUpdate=301");
    }else{
        response.sendRedirect("trainer.jsp?pUpdate=302");
    }
%>