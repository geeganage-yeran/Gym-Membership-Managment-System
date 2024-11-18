<%@page import="app.classes.email"%>
<%@page import="javax.mail.MessagingException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String recipient = request.getParameter("address");
    String memberAddress = request.getParameter("memberAddress");
    String messageText = request.getParameter("message");
    String subject = "FlexFire Fitness Member Request";
    String logo = "images/logo.png";
    String emailBody = "<html><body>"
            + "<h1 style='color:#f5540f' >Welcome to FlexFire Fitness</h1>"
            + "<p>" + messageText + "</p>"
            + "<p><b>You can reply to this : " + memberAddress + "</b></p>"
            + "</body></html>";

    try {
        email.sendEmail(recipient, subject, emailBody);
        response.sendRedirect("member.jsp?email=101");
    } catch (MessagingException e) {
        response.sendRedirect("member.jsp?email=102");
    }
%>
