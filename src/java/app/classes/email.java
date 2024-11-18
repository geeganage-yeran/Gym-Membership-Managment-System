;/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author YERAN
 */
public class email {

    public static void sendEmail(String to, String subject, String body) throws MessagingException, UnsupportedEncodingException {
        // Set up properties for the mail session
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // e.g., smtp.gmail.com
        props.put("mail.smtp.port", "587"); // or 465 for SSL

        // Create a session with an authenticator
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("kuppimate@gmail.com", "naoi ouog tqkw jgkr");
            }
        });

        // Create a message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("kuppimate@gmail.com","FlexFire Fitness"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(body);
        
         message.setContent(body, "text/html; charset=UTF-8");

        // Send the message
        Transport.send(message);
    }
}
