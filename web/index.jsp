<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>GYM Membership Management System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/index.css?v=<%= System.currentTimeMillis()%>">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <div class="wrapper">
            <div class="container main">
                <div class="row">
                    <div class="col-md-6 side-image">
                        <div class="text">
                            <p><span>FlexFire</span> Fitness</p>
                        </div>
                    </div>
                    <div class="col-md-6 right">
                        <div class="input-box">
                            <header>Login</header>
                            <form action="login.jsp" method="POST" >
                                <div class="input-field">
                                    <input type="email" class="input" id="email" name="email" required autocomplete="off">
                                    <label for="email">Email</label> 
                                </div> 
                                <div class="input-field">
                                    <input type="password" class="input" id="pass"name="password" required>
                                    <label for="pass">Password</label>
                                </div> 
                                <div class="input-field">
                                    <input type="submit" class="submit" value="Sign in">
                                </div>
                            </form>
                            <div class="signin">
                                <span>Don't you have an account? <a data-bs-toggle="modal" href="#staticBackdrop" >Register</a></span>
                            </div>
                            <div class="text-center mt-4">
                                <%
                                    if (request.getParameter("id") != null) {
                                        String message = "";
                                        if (request.getParameter("id").equals("1")) {
                                            message = "<h6 class='sMessage'>You have successfully registered with FlexFire Fitness.</h6>";
                                        } else if (request.getParameter("id").equals("0")) {
                                            message = "<h6 class='eMessage'>An error occurred. Please register again.</h6>";
                                        } else if (request.getParameter("id").equals("2")) {
                                            message = "<h6 class='eMessage'>Email Already Exist</h6>";
                                        }else if (request.getParameter("id").equals("4")) {
                                            message = "<h6 class='eMessage'>Invalid username or password or account is Deactivated</h6>";
                                        }

                                        if (!message.isEmpty()) {
                                            out.println(message);
                                        }
                                    }
                                %>
                            </div>
                        </div>  
                    </div>
                </div>
            </div>
        </div>
        <!--modal 1 for registration-->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">FlexFire Fitness Registration</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <a href="index.jsp"></a>
                    <form action="register.jsp" method="POST" >
                        <div class="modal-body">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingInput" name="fname" placeholder="" required="" >
                                <label for="floatingInput">First Name</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" name="lname" id="floatingInput" placeholder="" required="">
                                <label for="floatingInput">Last Name</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" name="email" id="floatingInput" placeholder="" required="">
                                <label for="floatingInput">Email</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required="">
                                <label for="floatingPassword">Password</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingPassword" name="Rpassword" placeholder="Password" required="">
                                <label for="floatingPassword">Confirm Password</label>
                            </div>
                            <div class="form-floating">
                                <select class="form-select" name="role" id="floatingSelect" required="">
                                    <option selected>Select Your Role</option>
                                    <option value="member">Member</option>
                                    <option value="trainer">Trainer</option>
                                </select>
                                <label for="floatingSelect">Role</label>
                            </div>
                            <div class="d-grid gap-2 mt-4">
                                <button  id="register" class="btn btn-primary btn-lg" type="submit">Register</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
