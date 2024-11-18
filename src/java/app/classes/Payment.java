/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author YERAN
 */
public class Payment {

    private int userId;
    private int trainerId;
    private String sessionTitle;
    private String payee;
    private String payeeEmail;
    private Date paidDate;
    private Date start_date;
    private String time_period;
    private String class_date;

    public Date getStart_date() {
        return start_date;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public String getTime_period() {
        return time_period;
    }

    public void setTime_period(String time_period) {
        this.time_period = time_period;
    }

    public String getClass_date() {
        return class_date;
    }

    public void setClass_date(String class_date) {
        this.class_date = class_date;
    }
            

    public String getPayee() {
        return payee;
    }

    public void setPayee(String payee) {
        this.payee = payee;
    }

    public String getPayeeEmail() {
        return payeeEmail;
    }

    public void setPayeeEmail(String payeeEmail) {
        this.payeeEmail = payeeEmail;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public String getSessionTitle() {
        return sessionTitle;
    }

    public void setSessionTitle(String sessionTitle) {
        this.sessionTitle = sessionTitle;
    }

    public Date getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Date paidDate) {
        this.paidDate = paidDate;
    }

    public Payment() {
    }

    public Payment(String sessionTitle, String payee, String payeeEmail, Date paidDate) {
        this.sessionTitle = sessionTitle;
        this.payee = payee;
        this.payeeEmail = payeeEmail;
        this.paidDate = paidDate;
    }

    public Payment(int userId, int trainerId, String sessionTitle) {
        this.userId = userId;
        this.trainerId = trainerId;
        this.sessionTitle = sessionTitle;
    }
    
     public Payment(String sessionTitle, Date start_date, String time_period, String class_date) {
        this.sessionTitle = sessionTitle;
        this.start_date = start_date;
        this.time_period = time_period;
        this.class_date = class_date;
    }

    public boolean createPayment(Connection con) {
        String query = "INSERT INTO subscribedsessions (userId, trainerId, session_title) VALUES (?, ?, ?)";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.userId);
            pstmt.setInt(2, this.trainerId);
            pstmt.setString(3, this.sessionTitle);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Payment.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public List<Payment> getPaymentDetails(Connection con) {
        List<Payment> coursePayments = new ArrayList<Payment>();
        String query = "SELECT s.*, u.firstName, u.email FROM subscribedsessions s JOIN users u ON s.userId = u.id WHERE s.trainerId = ?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.trainerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment(rs.getString("session_title"), rs.getString("firstName"), rs.getString("email"), rs.getDate("payment_date"));
                coursePayments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Payment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return coursePayments;
    }
    
    public List<Payment> getPaymentCourse(Connection con) {
        List<Payment> coursePayments = new ArrayList<Payment>();
        String query = "SELECT s.*,c.*  FROM subscribedsessions s JOIN classes c ON s.session_title = c.class_title WHERE s.userId = ?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment(rs.getString("session_title"), rs.getDate("start_date"), rs.getString("time_period"), rs.getString("class_date"));
                coursePayments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Payment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return coursePayments;
    }
    
    public void deleteSubcribedDetails(Connection con) {
        String query = "DELETE FROM subscribedsessions WHERE trainerId=? AND session_title=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.trainerId);
            pstmt.setString(1, this.sessionTitle);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Session.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
