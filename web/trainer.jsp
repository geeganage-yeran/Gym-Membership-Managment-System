<%-- 
    Document   : admin
    Created on : Aug 2, 2024, 10:39:21 PM
    Author     : YERAN
--%>

<%@page import="java.util.List"%>
<%@page import="app.classes.User" %>
<%@page import="app.classes.Payment" %>
<%@page import="app.classes.Session" %>
<%@page import="app.classes.DbConnector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! User user = new User();
    Session newClass = new Session();
    Payment newPayment = new Payment();
%>
<%
    if (session.getAttribute("id") == null && session.getAttribute("role") != "trainer") {
        response.sendRedirect("index.jsp");
    }
    String fname = (String) session.getAttribute("firstName");
    String status = (String) session.getAttribute("status");
    String lname = (String) session.getAttribute("lastName");
    String memberEmail = (String) session.getAttribute("email");
    String availability=(String) session.getAttribute("availability");
    String expertise=(String) session.getAttribute("expertise");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/ug-dashboard.css?v=<%= System.currentTimeMillis()%>">
        <link rel="stylesheet" href="css/trainer.css?v=<%= System.currentTimeMillis()%>">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <title>Trainer</title>
    </head>
    <body>
        <div class="sideBar" id="sidebar">
            <div class="profile">
                <h2><%= fname%></h2><i class="bi bi-x-lg" id="closeMenue"></i><br>
                <label class="fst-normal">Trainer</label>
                <span class="badge bg-success"><%= status%></span>
            </div>
            <ul class="navLinks">
                <li><a href="#" onclick="showSection('Schedule-Classes')" class="active"><i class="bi bi-house-fill"></i>&nbsp;&nbsp;&nbsp;Schedule Classes</a></li>
                <li><a href="#" onclick="showSection('Payments')"><i class="bi bi-people-fill"></i>&nbsp;&nbsp;&nbsp;Payments</a></li>
                <li><a href="#" onclick="showSection('Account')"><i class="bi bi-person-workspace"></i>&nbsp;&nbsp;&nbsp;Account</a></li>
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
            <section class="content" id="Schedule-Classes">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <h3 class="fw-bold" >Create Your Training Session With FlexFire Fitness</h3>
                <%
                    if (request.getParameter("class") != null) {
                        String message = "";
                        if (request.getParameter("class").equals("101")) {
                            message = "<h6 class='sMessage'>Class Created Successfully</h6>";
                        } else if (request.getParameter("class").equals("102")) {
                            message = "<h6 class='eMessage'>Failed To Create the Class</h6>";
                        } else if (request.getParameter("class").equals("201")) {
                            message = "<h6 class='sMessage'>Deleted the session Successfully</h6>";
                        } else if (request.getParameter("class").equals("202")) {
                            message = "<h6 class='eMessage'>Failed To Delete the session</h6>";
                        }
                        if (!message.isEmpty()) {
                            out.println(message);
                        }
                    }
                %>
                <form action="createClass.jsp" method="POST" >
                    <div class="container">
                        <div class="mb-3">
                            <label   class="form-label fw-bold">Class Title</label>
                            <input type="text" class="form-control" name="cTitle"  placeholder="Class Title Here" required="" >
                        </div>
                        <div class="mb-3">
                            <label   class="form-label fw-bold">Ammount</label>
                            <input type="number" class="form-control" name="cAmmount"  placeholder="Ammount Here" required="" >
                        </div>
                        <div class="mb-3">
                            <label  class="form-label fw-bold">Date to Start</label>
                            <input type="Date" class="form-control" name="cDate"  placeholder="Date Here" required="" >
                        </div>
                        <div class="mb-3">
                            <label for="formGroupExampleInput2" class="form-label fw-bold">Time Period</label>
                            <select class="form-select"   name="cTime" required="" >
                                <option selected>Select Time Period</option>
                                <option value="1">Less Than One Month</option>
                                <option value="1">One Month</option>
                                <option value="2">Two Month</option>
                                <option value="3">Three Month</option>
                                <option value="4">Four Month</option>
                                <option value="5">Five Month</option>
                                <option value="6">Six Month</option>
                                <option value="6">More Than Six Month</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label  class="form-label fw-bold">No of Sessions</label>
                            <input type="number" class="form-control"  name="noSessions" placeholder="Enter No of Sessions Here" required="" >
                        </div>
                        <div class="mb-3">
                            <label  class="form-label fw-bold">Class Date</label>
                            <input type="text" class="form-control"  name="shedule" placeholder="Every Sunday from (8.00am to 10.00am)" required="" >
                        </div>
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary activate" type="submit">Create The Class</button>
                        </div>
                    </div>
                </form>
                <%
                    int trainerId = (Integer) session.getAttribute("id");
                    newClass.setTrainerId(trainerId);
                    List<Session> classList = newClass.getClasses(DbConnector.getConnection());
                    if (classList != null) {
                        for (Session sessionList : classList) {
                %>
                <div class="container approved mt-4">
                    <div>
                        <label class="fw-bold mb-3 fs-3 mt-2"><%= sessionList.getClassTitle()%></label>
                        <br />
                        <label class="fw-bold mb-2">Fee :&nbsp; </label>
                        <label class="">LKR:<%= sessionList.getAmount()%></label>
                        <br />
                        <label class="fw-bold mb-2">Date To Start :&nbsp; </label>
                        <label class=""><%= sessionList.getStartDate()%></label>
                        <br />
                        <label class="fw-bold mb-2">No Of Sessions :&nbsp;</label>
                        <label class=""><%= sessionList.getNoOfSessions()%></label>
                        <br/>
                        <label class="fw-bold mb-2">Class Date :&nbsp;</label>
                        <label class=""><%= sessionList.getClassDate()%></label>
                        <br/>
                        <label class="fw-bold">Status :&nbsp;</label>
                        <label class=""><%= sessionList.getStatus()%></label>
                        <br/>
                        <button type="submit" data-bs-toggle="modal" data-bs-target="#deleteSession"  data-trainer-id="<%= sessionList.getTrainerId() %>"    data-member-id="<%= sessionList.getId() %>" data-session-title="<%= sessionList.getClassTitle() %>"  class="btn btn-danger btn-sm mt-2">Delete</button>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <label class="fw-bold">No Session Created Yet</label>
                <%
                    }
                %>


            </section>
            <section class="content" id="Payments">

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
                                <th scope="col">Date</th>
                                <th scope="col">Course Title</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int currentId = (Integer) session.getAttribute("id");
                                newPayment.setTrainerId(currentId);
                                List<Payment> paymentList = newPayment.getPaymentDetails(DbConnector.getConnection());
                                if (paymentList != null) {
                                    for (Payment payments : paymentList) {
                            %>
                            <tr>
                                <th scope="row">1</th>
                                <td><%= payments.getPayee()%></td>
                                <td><%= payments.getPayeeEmail()%></td>
                                <td><%= payments.getPaidDate()%></td>
                                <td><%= payments.getSessionTitle()%></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>No Payments Yet</tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>

            </section>
            <section class="content" id="Account">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <%
                    if (request.getParameter("pUpdate") != null) {
                        String message = "";
                        if (request.getParameter("pUpdate").equals("101")) {
                            message = "<h6 class='sMessage'>Profile Updated Successfully</h6>";
                        } else if (request.getParameter("pUpdate").equals("102")) {
                            message = "<h6 class='eMessage'>Failed to update profile</h6>";
                        } else if (request.getParameter("pUpdate").equals("103")) {
                            message = "<h6 class='eMessage'>Email Already Exist</h6>";
                        } else if (request.getParameter("pUpdate").equals("104")) {
                            message = "<h6 class='sMessage'>Password Updated Successfully</h6>";
                        } else if (request.getParameter("pUpdate").equals("105")) {
                            message = "<h6 class='eMessage'>Password Update Failed</h6>";
                        } else if (request.getParameter("pUpdate").equals("106")) {
                            message = "<h6 class='eMessage'>Password not matched</h6>";
                        }else if (request.getParameter("pUpdate").equals("301")) {
                            message = "<h6 class='sMessage'>Successfully Updated</h6>";
                        }else if (request.getParameter("pUpdate").equals("302")) {
                            message = "<h6 class='eMessage'>Failed To Update</h6>";
                        }else if (request.getParameter("pUpdate").equals("401")) {
                            message = "<h6 class='sMessage'>Added Expertise</h6>";
                        }else if (request.getParameter("pUpdate").equals("402")) {
                            message = "<h6 class='eMessage'>Failed To add Expertise</h6>";
                        }
                        if (!message.isEmpty()) {
                            out.println(message);
                        }
                    }
                %>
                <ul class="list-group mb-3">
                    <li class="list-group-item fw-bold">First Name : <span class="clr"><%= fname%></span> </li>
                    <li class="list-group-item fw-bold">Last Name : <span class="clr" ><%= lname%></span></li>
                    <li class="list-group-item fw-bold">Email : <span class="clr"><%= memberEmail%></span></li>
                    <li class="list-group-item fw-bold">Expertise : <span class="clr"><%= expertise %></span></li>
                </ul>
                <h3 class="fw-bold" >Availability<span class="badge bg-success ms-3"><%= availability %></span></h3>
                <div class="container">
                    <form action="updateAvailability.jsp" method="POST" >
                        <select name="availability" class="form-select">
                            <option value="yes">Yes</option>
                            <option value="no">No</option>
                        </select>
                        <button type="submit" class="btn btn-primary mt-3 activate">Update Status</button>
                    </form>
                </div>
                <h3 class="fw-bold" >Edit Profile</h3>
                <div class="container">
                    <form action="trainerUpdateProfile.jsp" method="POST" >
                        <div class="row g-3">
                            <div class="col">
                                <input type="text" class="form-control" placeholder="First name" name="fname" aria-label="First name">
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" placeholder="Last name" name="lname" aria-label="Last name">
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col">
                                <input type="email" class="form-control" placeholder="email" name="email" aria-label="email">
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="button" class="btn btn-outline-primary activateB">Cancel</button>
                            <button type="submit" class="btn btn-primary activate">Update Profile</button>
                        </div>
                    </form>
                </div>
                <h3 class="fw-bold" >Update Password</h3>
                <div class="container">
                    <form action="trainerUpdatePassword.jsp" method="POST" >
                        <div class="row g-3">
                            <div class="col">
                                <input type="password" class="form-control" name="oldPwd" required="" placeholder="Current Password" aria-label="cpassowrd">
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col">
                                <input type="password" class="form-control" name="newPwd" required="" placeholder="New Password" aria-label="newpsw">
                            </div>
                            <div class="col">
                                <input type="password" class="form-control" name="confirmPwd" required="" placeholder="New Password Again" aria-label="newpswagain">
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="button" class="btn btn-outline-primary activateB">Cancel</button>
                            <button type="submit" class="btn btn-primary activate">Update Password</button>
                        </div>
                    </form>
                </div>
                <h3 class="fw-bold" >Add Expertise</h3>
                <div class="container">
                    <form action="addExpertise.jsp" method="POST" >
                    <select name="expertise" class="form-select" >
                        <option>Select</option>
                        <option value="personal_training">Personal Training</option>
                        <option value="group_fitness">Group Fitness Classes</option>
                        <option value="nutrition_coaching">Nutrition Coaching</option>
                        <option value="strength_training">Strength Training</option>
                        <option value="cardio_training">Cardio Training</option>
                        <option value="weight_loss">Weight Loss Programs</option>
                        <option value="bodybuilding">Bodybuilding</option>
                        <option value="yoga">Yoga</option>
                        <option value="pilates">Pilates</option>
                        <option value="kettlebell_training">Kettlebell Training</option>
                    </select>
                    <button type="submit" class="btn btn-primary mt-3 activate">Add Expertise</button>
                    </form>
                </div>

            </section>
        </div>
        <!--Delete Confirmations-->
        <div class="modal fade" id="deleteSession" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteSessionLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        Do you want to delete this session ?
                    </div>
                    <div class="modal-footer">
                        <form action="deleteSession.jsp" method="post">
                            <input type="hidden" id="sessionIdInput" name="sessionId" value="">
                             <input type="hidden" id="trainerIdInput" name="trainerId" value="">
                             <input type="hidden" id="titleInput" name="title" value="">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="submit" class="btn btn-primary modalBtn">Yes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const deleteButtons = document.querySelectorAll('.btn-danger');
            const sessionIdInput = document.querySelector('#sessionIdInput');
            const trainerIdInput = document.querySelector('#trainerIdInput');
            const titleInput = document.querySelector('#titleInput');

            deleteButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const SessionId = this.getAttribute('data-member-id');
                    const trainerId = this.getAttribute('data-trainer-id');
                    const title = this.getAttribute('data-session-title');
                    sessionIdInput.value = SessionId;
                    trainerIdInput.value = trainerId;
                    titleInput.value = title;
                });
            });
        </script>
        <script src="js/trainer.js?v=<%= System.currentTimeMillis()%>"></script>
    </body>
</html>
