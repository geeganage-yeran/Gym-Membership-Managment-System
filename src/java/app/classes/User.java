/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.Connection;
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
public class User {

    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String role;
    private String accountStatus;
    private String password;
    private String availability;
    private String expertise;

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = MD5.getMd5(password);
    }

    public String getEmail() {
        return email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public User() {
    }

    public User(String firstName, String email, String availability, String expertise) {
        this.firstName = firstName;
        this.email = email;
        this.availability = availability;
        this.expertise = expertise;
    }

    public User(String firstName, String lastName, String email, String role, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
        this.password = MD5.getMd5(password);
    }

    public User(int id, String firstName, String lastName, String email, String accountStatus) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.accountStatus = accountStatus;
    }

    public User(String email, String password) {
        this.email = email;
        this.password = MD5.getMd5(password);
    }

    public Boolean register(Connection con) {
        this.accountStatus = "active";
        String query = "INSERT INTO users(firstName,lastName,email,role,accountStatus,password) VALUES (?,?,?,?,?,?)";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.firstName);
            pstmt.setString(2, this.lastName);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.role);
            pstmt.setString(5, this.accountStatus);
            pstmt.setString(6, this.password);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }

    public Boolean verifiyUser(Connection con, String mail) {
        String query = "SELECT email FROM users WHERE email=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, mail);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Boolean authentication(Connection con) {
        String query = "SELECT * FROM users WHERE email=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("password").equals(this.password) && rs.getString("accountStatus").equals("active")) {
                    this.setId(rs.getInt("id"));
                    this.setFirstName(rs.getString("firstName"));
                    this.setLastName(rs.getString("lastName"));
                    this.setRole(rs.getString("role"));
                    this.setAccountStatus(rs.getString("accountStatus"));
                    this.setAvailability(rs.getString("availability"));
                    this.setExpertise(rs.getString("expertise"));
                    return true;
                } else {
                    return false;
                }

            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }

    public List<User> getMemberList(Connection con) {
        List<User> userList = new ArrayList<User>();
        try {
            String query = "SELECT * FROM users WHERE role='member'";
            PreparedStatement pstmt;
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName"), rs.getString("email"), rs.getString("accountStatus"));
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public List<User> getTrainerList(Connection con) {
        List<User> trainerList = new ArrayList<User>();
        try {
            String query = "SELECT * FROM users WHERE role='trainer'";
            PreparedStatement pstmt;
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName"), rs.getString("email"), rs.getString("accountStatus"));
                trainerList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return trainerList;
    }

    public Boolean deleteUser(Connection con, int userId) {
        String query = "DELETE FROM users WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Boolean deactivateUser(Connection con, int userId) {
        String query = "UPDATE users SET accountStatus='inactive' WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Boolean activateUser(Connection con, int userId) {
        String query = "UPDATE users SET accountStatus='active' WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public List<User> trainerList(Connection con) {
        List<User> trainerList = new ArrayList<User>();
        String query = "SELECT * FROM users WHERE role=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, "trainer");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getString("firstName"), rs.getString("email"), rs.getString("availability"), rs.getString("expertise"));
                trainerList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return trainerList;
    }

    public Boolean updateProfile(Connection con) {
        String query = "UPDATE users SET ";
        boolean setAnyFiled = false;

        if (this.firstName != null && !this.firstName.isEmpty()) {
            query += "firstName = ?";
            setAnyFiled = true;
        }

        if (this.lastName != null && !this.lastName.isEmpty()) {
            if (setAnyFiled) {
                query += ", ";
            }
            query += "lastName = ?";
            setAnyFiled = true;
        }

        if (this.email != null && !this.email.isEmpty()) {
            if (setAnyFiled) {
                query += ", ";
            }
            query += "email = ?";
        }

        if (!setAnyFiled) {
            return false;
        }

        query += " WHERE id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            int index = 1;

            if (this.firstName != null && !this.firstName.isEmpty()) {
                pstmt.setString(index++, this.firstName);
            }
            if (this.lastName != null && !this.lastName.isEmpty()) {
                pstmt.setString(index++, this.lastName);
            }
            if (this.email != null && !this.email.isEmpty()) {
                pstmt.setString(index++, this.email);
            }

            pstmt.setInt(index, this.id);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Boolean updatePassword(Connection con, String newPwd) {
        String query = "SELECT password FROM users WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String oldPassword = rs.getString("password");
                if (oldPassword.equals(this.password)) {
                    String query1 = "UPDATE users SET password=? WHERE id=?";
                    pstmt = con.prepareStatement(query1);
                    pstmt.setString(1, MD5.getMd5(newPwd));
                    pstmt.setInt(2, this.id);
                    return pstmt.executeUpdate() > 0;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }

    public Boolean updateAvailability(Connection con) {
        String query = "UPDATE users SET availability=? WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.availability);
            pstmt.setInt(2, this.id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }
    
    public Boolean addExpertise(Connection con){
        String query="UPDATE users SET expertise=? WHERE id=?";
        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.expertise);
            pstmt.setInt(2, this.id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
