<%-- 
    Document   : login
    Created on : Aug 7, 2024, 7:10:23 PM
    Author     : YERAN
--%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    boolean isValid = true;
    String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
    if (email == null || !Pattern.matches(emailRegex, email)) {
        isValid = false;
    }
    if (password == null || password.isEmpty()) {
        isValid = false;
    }

    if (isValid) {
        email = email.trim();
        password = password.trim();

        User user = new User(email, password);
        if (user.authentication(DbConnector.getConnection())) {
            session.setAttribute("id", user.getId());
            user.setId(user.getId());
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("status", user.getAccountStatus());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("availability", user.getAvailability());
            session.setAttribute("expertise", user.getExpertise());

            if (user.getRole().equals("admin")) {
                response.sendRedirect("admin.jsp");
            } else if (user.getRole().equals("member")) {
                response.sendRedirect("member.jsp");
            } else if (user.getRole().equals("trainer")) {
                response.sendRedirect("trainer.jsp");
            }
        } else {
            response.sendRedirect("index.jsp?id=4");
        }
    }
%>