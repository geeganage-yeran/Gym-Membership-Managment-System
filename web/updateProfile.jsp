<%-- 
    Document   : updateProfile
    Created on : Aug 8, 2024, 7:55:20 PM
    Author     : YERAN
--%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    Boolean needToUpdate = false;

    User user = new User();
    if (fname != null && !fname.trim().isEmpty()) {
        user.setFirstName(fname.trim().replaceAll("[^a-zA-Z]", ""));
        session.setAttribute("firstName", user.getFirstName());
        needToUpdate = true;
    }
    if (lname != null && !lname.trim().isEmpty()) {
        user.setLastName(lname.trim().replaceAll("[^a-zA-Z]", ""));
        session.setAttribute("lastName", user.getLastName());
        needToUpdate = true;
    }
    if (email != null && !email.trim().isEmpty()) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (Pattern.matches(emailRegex, email)) {
            if (user.verifiyUser(DbConnector.getConnection(), email)) {
                response.sendRedirect("member.jsp?pUpdate=103");
            } else {
                user.setEmail(email);
                session.setAttribute("email", user.getEmail());
                needToUpdate = true;
            }
        }
    }
    if (needToUpdate) {
        int id = (Integer) session.getAttribute("id");
        user.setId(id);
        if (user.updateProfile(DbConnector.getConnection())) {
            response.sendRedirect("member.jsp?pUpdate=101");
        } else {
            response.sendRedirect("member.jsp?pUpdate=102");
        }
    }

%>
