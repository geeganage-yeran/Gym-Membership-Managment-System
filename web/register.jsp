<%-- 
    Document   : register
    Created on : Aug 7, 2024, 5:06:10 PM
    Author     : YERAN
--%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.*"%>
<%
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("Rpassword");
    String role = request.getParameter("role");

    boolean isValid = true;

    if (fname == null || fname.trim().isEmpty() || !fname.matches("[a-zA-Z]+")) {
        isValid = false;
    }
    if (lname == null || lname.trim().isEmpty() || !lname.matches("[a-zA-Z]+")) {
        isValid = false;
    }
    String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
    if (email == null || !Pattern.matches(emailRegex, email)) {
        isValid = false;
    }
    if (password == null || password.length() < 6) {
        isValid = false;
    }
    if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
        isValid = false;
    }
    if (isValid) {
        fname = fname.trim().replaceAll("[^a-zA-Z]", "");
        lname = lname.trim().replaceAll("[^a-zA-Z]", "");
        email = email.trim();
        password = password.trim();
        role = role.trim().replaceAll("[^a-zA-Z]", "");

        User user = new User(fname, lname, email, role, password);
        if (!user.verifiyUser(DbConnector.getConnection(),email)) {
            if (user.register(DbConnector.getConnection())) {
                response.sendRedirect("index.jsp?id=1");
            } else {
                response.sendRedirect("index.jsp?id=0");
            }
        } else {
            response.sendRedirect("index.jsp?id=2");
        }

    } else {
        response.sendRedirect("index.jsp?id=0");
    }
%>

