<%@page import="app.classes.Session" %>
<%
    if (session.getAttribute("id") == null && session.getAttribute("role") != "member") {
        response.sendRedirect("index.jsp");
    }
    int trainerId =Integer.parseInt(request.getParameter("trainerId"));
    int userId=(Integer) session.getAttribute("id");
    double ammount = Double.parseDouble(request.getParameter("sessionAmmount"));
    String sessionTitle=request.getParameter("sessionTitle");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="css/payment.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Payment Page</title>
</head>
<body>
    
    <!-- start: Payment -->
    <section class="payment-section">
        <div class="container">
            <div class="payment-wrapper">
                <div class="payment-left">
                    <div class="payment-header">
                        <div class="payment-header-icon">FlexFire Fitness Payment Portal</div>
                        <div class="payment-header-title"><%= sessionTitle %></div>
                        <p class="payment-header-description">FlexFire Ftness</p>
                    </div>
                    <div class="payment-content">
                        <div class="payment-body">
                            <div class="payment-plan">
                                <div class="payment-plan-type"><i class="bi bi-cash"></i></div>
                                <div class="payment-plan-info">
                                    <div class="payment-plan-info-name">Total</div>
                                    <div class="payment-plan-info-price">LKR <%= ammount %> </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="payment-right">
                    <form action="processPayment.jsp" class="payment-form">
                        <h1 class="payment-title">Payment Details</h1>
                        <div class="payment-method">
                            <input type="radio" name="payment-method" id="method-1" checked>
                            <label for="method-1" class="payment-method-item">
                                <img src="images/visa.png" alt="">
                            </label>
                            <input type="radio" name="payment-method" id="method-2">
                            <label for="method-2" class="payment-method-item">
                                <img src="images/mastercard.png" alt="">
                            </label>
                            <input type="radio" name="payment-method" id="method-3">
                            <label for="method-3" class="payment-method-item">
                                <img src="images/paypal.png" alt="">
                            </label>
                            <input type="radio" name="payment-method" id="method-4">
                            <label for="method-4" class="payment-method-item">
                                <img src="images/stripe.png" alt="">
                            </label>
                        </div>
                        <div class="payment-form-group">
                            <input type="email" placeholder=" " required="" class="payment-form-control" id="email">
                            <label for="email" class="payment-form-label payment-form-label-required">Email Address</label>
                        </div>
                        <div class="payment-form-group">
                            <input type="number" placeholder=" " required="" class="payment-form-control" id="card-number">
                            <label for="card-number" class="payment-form-label payment-form-label-required">Card Number</label>
                        </div>
                        <div class="payment-form-group-flex">
                            <div class="payment-form-group">
                                <input type="date" placeholder=" " required="" class="payment-form-control" id="expiry-date">
                                <label for="expiry-date" class="payment-form-label payment-form-label-required">Expiry Date</label>
                            </div>
                            <div class="payment-form-group">
                                <input type="number" placeholder=" " required="" class="payment-form-control" id="cvv">
                                <label for="cvv" class="payment-form-label payment-form-label-required">CVV</label>
                            </div>
                            <input type="number" hidden="" name="trainerId" value="<%= trainerId %>" >
                            <input type="number" hidden="" name="userId" value="<%= userId %>" >
                            <input type="text" hidden="" name="sessionTitle" value="<%= sessionTitle %>" >
                        </div>
                        <button type="submit" class="payment-form-submit-button"><i class="ri-wallet-line"></i> Pay</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- end: Payment -->

</body>
</html>