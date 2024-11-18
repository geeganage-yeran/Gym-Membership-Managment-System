<%-- 
    Document   : admin
    Created on : Aug 2, 2024, 10:39:21 PM
    Author     : YERAN
--%>

<%@page import="java.util.List"%>
<%@page import="app.classes.User" %>
<%@page import="app.classes.Session" %>
<%@page import="app.classes.Payment" %>
<%@page import="app.classes.DbConnector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! User user = new User();
    Session newClass = new Session();
    Payment payment=new Payment();
%>
<%
    if (session.getAttribute("id") == null && session.getAttribute("role") != "member") {
        response.sendRedirect("index.jsp");
    }
    String fname = (String) session.getAttribute("firstName");
    String lname = (String) session.getAttribute("lastName");
    String status = (String) session.getAttribute("status");
    String memberEmail = (String) session.getAttribute("email");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/ug-dashboard.css?v=<%= System.currentTimeMillis()%>">
        <link rel="stylesheet" href="css/member.css?v=<%= System.currentTimeMillis()%>">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <title>Member</title>
    </head>
    <body>
        <div class="sideBar" id="sidebar">
            <div class="profile">
                <h2><%=fname.toUpperCase()%></h2><i class="bi bi-x-lg" id="closeMenue"></i><br>
                <label class="fst-normal">Member</label>
                <span class="badge bg-success"><%=status%></span>
            </div>
            <ul class="navLinks">
                <li><a href="#" onclick="showSection('Training-Sessions')" class="active"><i class="bi bi-house-fill"></i>&nbsp;&nbsp;&nbsp;Training Sessions</a></li>
                <li><a href="#" onclick="showSection('Personal-Trainers')"><i class="bi bi-people-fill"></i>&nbsp;&nbsp;&nbsp;Personal Trainers</a></li>
                <li><a href="#" onclick="showSection('Subscribed-Sessions')"><i class="bi bi-person-workspace"></i>&nbsp;&nbsp;&nbsp;Subscribed Sessions</a></li>
                <li><a href="#" onclick="showSection('Account')"><i class="bi bi-person-lines-fill"></i>&nbsp;&nbsp;&nbsp;Account</a></li>
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
            <section class="content" id="Training-Sessions">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <h3 class="fw-bold" >Enroll With Training Sessions</h3>
                <%
                    if (request.getParameter("payment") != null) {
                        String message = "";
                        if (request.getParameter("payment").equals("101")) {
                            message = "<h6 class='sMessage'>Payment Success</h6>";
                        } else if (request.getParameter("payment").equals("102")) {
                            message = "<h6 class='eMessage'>Payment Failed</h6>";
                        }
                        if (!message.isEmpty()) {
                            out.println(message);
                        }
                    }
                %>
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <%
                        List<Session> AllClassList = newClass.getAllClasses(DbConnector.getConnection());
                        if (AllClassList != null) {
                            for (Session classList : AllClassList) {
                    %>
                    <div class="col">
                        <div class="card">
                            <img src="images/session.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title fw-bold"><%= classList.getClassTitle()%></h5>
                                <h6 class="card-title "><span class="fw-bold">Name : </span><%= classList.getSessionConductor()%></h6>
                                <h6 class="card-title"><span class="fw-bold">No Of Sessions : </span><%= classList.getNoOfSessions()%></h6>
                                <h6 class="card-title"><span class="fw-bold">Start Date : </span><%= classList.getStartDate()%></h6> 
                                <h6 class="card-title"><span class="fw-bold">Email : </span><%= classList.getTrainerEmail()%></h6>  
                                <h5 class="card-title fw-bold"><span class="fw-bold">Fee LKR : </span><%= classList.getAmount()%></h5>
                                <form action="payment.jsp" method="POST" >
                                    <input type="text" value="<%= classList.getTrainerId()%>" name="trainerId" hidden="">
                                    <input type="text" value="<%= classList.getClassTitle()%>" name="sessionTitle" hidden=""> 
                                    <input type="number" value="<%= classList.getAmount()%>" name="sessionAmmount" hidden="">  
                                    <button type="submit" class="btn btn-secondary activate">Buy Now</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <label class="fw-bold">No Session Yet</label>
                    <%
                        }
                    %>
                </div>

            </section>
            <section class="content" id="Personal-Trainers">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <div class="table-responsive">
                    <%
                        if (request.getParameter("email") != null) {
                            String message = "";
                            if (request.getParameter("email").equals("101")) {
                                message = "<h6 class='sMessage'>Message Sent Successfully</h6>";
                            } else if (request.getParameter("email").equals("102")) {
                                message = "<h6 class='eMessage'>Failed to send Email</h6>";
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
                                <th scope="col">Trainer Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Expertise</th>
                                <th scope="col">Availability</th>
                                <th scope="col">Action</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<User> trainerList = user.trainerList(DbConnector.getConnection());
                                if (trainerList != null) {
                                    int index = 1;
                                    for (User trainer : trainerList) {
                            %>
                            <tr>
                                <th scope="row"><%= index++%></th>
                                <td><%= trainer.getFirstName()%></td>
                                <td><%= trainer.getEmail()%></td>
                                <td><%= trainer.getExpertise()%></td>
                                <td><%= trainer.getAvailability()%></td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm activate send" data-bs-toggle="modal" data-bs-target="#emailSend" data-member-id="<%=trainer.getEmail()%>">Send a Email</button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="6">No trainers found.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

            </section>
            <section class="content" id="Subscribed-Sessions">

                <div class="headerImage">
                    <img class="img-fluid" src="images/headerImage.png" alt="header-image">
                </div>
                <%
                    int currentId = (Integer) session.getAttribute("id");
                    payment.setUserId(currentId);
                    List<Payment> paidCourses =payment.getPaymentCourse(DbConnector.getConnection());
                    if (paidCourses != null) {
                        for (Payment paidList : paidCourses) {
                %>
                <div class="accordion" id="accordionExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                <%= paidList.getSessionTitle() %>
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <span class="fw-bold" >Time Period : </span><%= paidList.getTime_period() %><br/>
                                 <span class="fw-bold" >Class Date : </span><%= paidList.getStart_date() %><br/>
                                 <span class="fw-bold" >Class Time: :</span><%= paidList.getClass_date()%>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                       }
                   } else {
                %>
                <label class="fw-bold">No paid sessions </label>
                <%
                    }
                %>

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
                </ul>
                <h3 class="fw-bold" >Edit Profile</h3>
                <div class="container">
                    <form action="updateProfile.jsp" method="POST" >
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
                    <form action="updatePassword.jsp" method="POST" >
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

            </section>
        </div>
        <!--email popup-->
        <div class="modal fade" id="emailSend" data-bs-backdrop="static" tabindex="-1" aria-labelledby="emailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Send a Message</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="sendEmail.jsp" method="POST" >
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="message-text" class="col-form-label">Message:</label>
                                <input type="email" id="trainerEmailInput" value="" hidden="" name="address">
                                <input type="email"  value="<%=memberEmail%>" hidden="" name="memberAddress">
                                <textarea class="form-control" id="message-text" name="message" required="" ></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary ">Send message</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            const sendButton = document.querySelectorAll('.send');
            const trainerEmailInput = document.querySelector('#trainerEmailInput');

            sendButton.forEach(button => {
                button.addEventListener('click', function () {
                    const trainerEmail = this.getAttribute('data-member-id');
                    trainerEmailInput.value = trainerEmail; // Set the member ID in the hidden input
                });
            });
        </script>
        <script src="js/member.js?v=<%= System.currentTimeMillis()%>"></script>
    </body>
</html>
