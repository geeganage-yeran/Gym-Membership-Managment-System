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
public class Session {

    private String classTitle;
    private double amount;
    private Date startDate;
    private String timePeriod;
    private int noOfSessions;
    private String classDate;
    private int trainerId;
    private String status;
    private String SessionConductor;
    private String trainerEmail;
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSessionConductor() {
        return SessionConductor;
    }

    public void setSessionConductor(String SessionConductor) {
        this.SessionConductor = SessionConductor;
    }

    public String getTrainerEmail() {
        return trainerEmail;
    }

    public void setTrainerEmail(String trainerEmail) {
        this.trainerEmail = trainerEmail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getClassTitle() {
        return classTitle;
    }

    public void setClassTitle(String classTitle) {
        this.classTitle = classTitle;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public String getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(String timePeriod) {
        this.timePeriod = timePeriod;
    }

    public int getNoOfSessions() {
        return noOfSessions;
    }

    public void setNoOfSessions(int noOfSessions) {
        this.noOfSessions = noOfSessions;
    }

    public String getClassDate() {
        return classDate;
    }

    public void setClassDate(String classDate) {
        this.classDate = classDate;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public Session() {
    }

    public Session(String classTitle, double amount, Date startDate, String timePeriod, int noOfSessions, String classDate, String SessionConductor, String trainerEmail,int trainerId) {
        this.classTitle = classTitle;
        this.amount = amount;
        this.startDate = startDate;
        this.timePeriod = timePeriod;
        this.noOfSessions = noOfSessions;
        this.classDate = classDate;
        this.SessionConductor = SessionConductor;
        this.trainerEmail = trainerEmail;
        this.trainerId=trainerId;
    }

    public Session(String classTitle, double amount, Date startDate, String timePeriod, int noOfSessions, String classDate, int trainerId) {
        this.classTitle = classTitle;
        this.amount = amount;
        this.startDate = startDate;
        this.timePeriod = timePeriod;
        this.noOfSessions = noOfSessions;
        this.classDate = classDate;
        this.trainerId = trainerId;
    }

    public Session(int id,String classTitle, double amount, Date startDate, String timePeriod, int noOfSessions, String classDate, int trainerId, String status) {
        this.classTitle = classTitle;
        this.amount = amount;
        this.startDate = startDate;
        this.timePeriod = timePeriod;
        this.noOfSessions = noOfSessions;
        this.classDate = classDate;
        this.trainerId = trainerId;
        this.status = status;
        this.id=id;
    }

    public Boolean createClass(Connection con) {
        String query = "INSERT INTO classes (class_title, amount, start_date, time_period, no_of_sessions, class_date, trainerId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.classTitle);
            pstmt.setDouble(2, this.amount);
            pstmt.setDate(3, this.startDate);
            pstmt.setString(4, this.timePeriod);
            pstmt.setInt(5, this.noOfSessions);
            pstmt.setString(6, this.classDate);
            pstmt.setInt(7, this.trainerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Session.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }

    public List<Session> getClasses(Connection con) {
        List<Session> classList = new ArrayList<Session>();
        String query = "SELECT * FROM classes WHERE trainerId=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.trainerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Session newClass = new Session(rs.getInt("id"),rs.getString("class_title"), rs.getDouble("amount"), rs.getDate("start_date"), rs.getString("time_period"), rs.getInt("no_of_sessions"), rs.getString("class_date"), rs.getInt("trainerId"), rs.getString("status"));
                classList.add(newClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Session.class.getName()).log(Level.SEVERE, null, ex);
        }
        return classList;
    }
    
    public List<Session> getAllClasses(Connection con) {
        List<Session> AllClassList = new ArrayList<Session>();
        String query = "SELECT c.*, u.firstName, u.email FROM classes c JOIN users u ON c.trainerId = u.id";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Session newClass = new Session(rs.getString("class_title"), rs.getDouble("amount"), rs.getDate("start_date"), rs.getString("time_period"), rs.getInt("no_of_sessions"), rs.getString("class_date"),rs.getString("firstName"), rs.getString("email"),rs.getInt("trainerId"));
                AllClassList.add(newClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Session.class.getName()).log(Level.SEVERE, null, ex);
        }
        return AllClassList;
    }

    public Boolean deleteSession(Connection con) {
        String query = "DELETE FROM classes WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Session.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
