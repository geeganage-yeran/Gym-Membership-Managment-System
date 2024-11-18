<%-- 
    Document   : createClass
    Created on : Aug 9, 2024, 9:21:50 AM
    Author     : YERAN
--%>
<%@page import="java.sql.Date"%>
<%@page import="app.classes.DbConnector" %>
<%@page import="app.classes.Session" %>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String classTitle = request.getParameter("cTitle");
    double amount = Double.parseDouble(request.getParameter("cAmmount"));
    Date startDate = java.sql.Date.valueOf(request.getParameter("cDate"));
    String timePeriod = request.getParameter("cTime");
    int noOfSessions = Integer.parseInt(request.getParameter("noSessions"));
    String classDate = request.getParameter("shedule");
    int trainerId = (Integer) session.getAttribute("id");

    boolean isValid = true;

    if (classTitle == null || classTitle.trim().isEmpty()) {
        isValid = false;
    }
    if (classDate == null || classDate.trim().isEmpty()) {
        isValid = false;
    }

    if (isValid) {
        Session newClass = new Session(classTitle, amount, startDate, timePeriod, noOfSessions, classDate, trainerId);
        if (newClass.createClass(DbConnector.getConnection())) {
            newClass.setTrainerId(trainerId);
            response.sendRedirect("trainer.jsp?class=101");
        } else {
            response.sendRedirect("trainer.jsp?class=102");
        }
    }


%>
