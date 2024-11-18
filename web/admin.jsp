<%-- 
    Document   : admin
    Created on : Aug 2, 2024, 10:39:21 PM
    Author     : YERAN
--%>
<%@page import="java.util.List"%>
<%@page import="app.classes.User" %>
<%@page import="app.classes.DbConnector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! User user = new User();%>
<%
    if (session.getAttribute("id") == null && session.getAttribute("role") != "admin") {
        response.sendRedirect("index.jsp");
    }
    String fname = (String) session.getAttribute("firstName");
    String status = (String) session.getAttribute("status");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/ug-dashboard.css?v=<%= System.currentTimeMillis()%>">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <title>Admin</title>
    </head>
    <body>
        <div class="sideBar" id="sidebar">
            <div class="profile">
                <h2><%=fname.toUpperCase()%></h2><i class="bi bi-x-lg" id="closeMenue"></i><br>
                <label class="fst-normal">Administrator</label>
                <span class="badge bg-success"><%=status%></span>
            </div>
            <ul class="navLinks">
                <li><a href="#" onclick="showSection('Member-Management')" class="active"><i class="bi bi-house-fill"></i>&nbsp;&nbsp;&nbsp;Member Management</a></li>
                <li><a href="#" onclick="showSection('Trainer-Management')"><i class="bi bi-people-fill"></i>&nbsp;&nbsp;&nbsp;Trainer Management</a></li>
                <li><a href="logout.jsp"><i class="bi bi-box-arrow-left"></i>&nbsp;&nbsp;&nbsp;Log out</a></li>
            </ul>
        </div>
        <div class="mainContainer">
            <header>
                <div class="ham" id="hambMenu">
                    <i class="bi bi-list"></i>
                </div>
                <h1 id="header-title"></h1>
                <img src="images/logo.png" alt="Logo">
            </header>
            <section class="content" id="Member-Management">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <div class="table-responsive">
                    <%
                        if (request.getParameter("id") != null) {
                            String message = "";
                            if (request.getParameter("id").equals("1")) {
                                message = "<h6 class='sMessage'>Deleted Successfully</h6>";
                            } else if (request.getParameter("id").equals("2")) {
                                message = "<h6 class='eMessage'>An error occurred. Please try again.</h6>";
                            } else if (request.getParameter("id").equals("15")) {
                                message = "<h6 class='sMessage'>Successfully Activated</h6>";
                            } else if (request.getParameter("id").equals("16")) {
                                message = "<h6 class='eMessage'>Error Occured</h6>";
                            } else if (request.getParameter("id").equals("17")) {
                                message = "<h6 class='sMessage'>Succefully Deactivated</h6>";
                            }
                            if (!message.isEmpty()) {
                                out.println(message);
                            }
                        }
                    %>
                    <table class="table text-center align-middle">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Member Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Status</th>
                                <th scope="col">Change Status</th>
                                <th scope="col">Action</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<User> userList = user.getMemberList(DbConnector.getConnection());
                                if (userList != null) {
                                    int index = 1;
                                    for (User member : userList) {
                            %>
                            <tr>
                                <th scope="row"><%= index++%></th>
                                <td><%= member.getFirstName() + " " + member.getLastName()%></td>
                                <td><%= member.getEmail()%></td>
                                <td><span class="badge <%= member.getAccountStatus().equals("active") ? "bg-success" : "bg-danger"%>"><%= member.getAccountStatus()%></span></td>
                                <td>
                                    <form action="changeStatus.jsp" method="POST">
                                        <input type="hidden" name="userId" value="<%= member.getId()%>">
                                        <%
                                            if ("active".equals(member.getAccountStatus())) {
                                        %>
                                        <input type="hidden" name="action" value="deactivate">
                                        <button type="submit" class="btn btn-danger btn-sm">Deactivate</button>
                                        <%
                                        } else {
                                        %>
                                        <input type="hidden" name="action" value="activate">
                                        <button type="submit" class="btn btn-primary btn-sm activate">Activate</button>
                                        <%
                                            }
                                        %>
                                    </form>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteMember" data-member-id="<%= member.getId()%>">Delete</button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="6">No Members found.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

            </section>
            <section class="content" id="Trainer-Management">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <div class="table-responsive">
                    <table class="table text-center align-middle">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Member Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Status</th>
                                <th scope="col">Change Status</th>
                                <th scope="col">Action</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<User> trainerList = user.getTrainerList(DbConnector.getConnection());
                                if (trainerList != null) {
                                    int index = 1;
                                    for (User trainer : trainerList) {
                            %>
                            <tr>
                                <th scope="row"><%= index++%></th>
                                <td><%= trainer.getFirstName() + " " + trainer.getLastName()%></td>
                                <td><%= trainer.getEmail()%></td>
                                <td><span class="badge <%= trainer.getAccountStatus().equals("active") ? "bg-success" : "bg-danger"%>"><%= trainer.getAccountStatus()%></span></td>
                                <td>
                                    <form action="changeStatus.jsp" method="POST">
                                        <input type="hidden" name="userId" value="<%=trainer.getId()%>">
                                        <%
                                            // Check the account status
                                            if ("active".equals(trainer.getAccountStatus())) {
                                        %>
                                        <input type="hidden" name="action" value="deactivate">
                                        <button type="submit" class="btn btn-danger btn-sm">Deactivate</button>
                                        <%
                                        } else {
                                        %>
                                        <input type="hidden" name="action" value="activate">
                                        <button type="submit" class="btn btn-primary btn-sm activate">Activate</button>
                                        <%
                                            }
                                        %>
                                    </form>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteMember" data-member-id="<%=trainer.getId()%>">Delete</button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="6">No Trainers found.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

            </section>
        </div>
        <!--Delete Confirmations-->
        <div class="modal fade" id="deleteMember" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteMemberLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        Do you want to delete this member ?
                    </div>
                    <div class="modal-footer">
                        <form action="delete.jsp" method="post">
                            <input type="hidden" name="memberId" id="memberIdInput" value="">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="submit" class="btn btn-primary">Yes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            const deleteButtons = document.querySelectorAll('.btn-danger');
            const memberIdInput = document.querySelector('#memberIdInput');

            deleteButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const memberId = this.getAttribute('data-member-id');
                    memberIdInput.value = memberId; // Set the member ID in the hidden input
                });
            });
        </script>

        <script src="js/ug-dashboard.js?v=<%= System.currentTimeMillis()%>"></script>
    </body>
</html>
