<!DOCTYPE html>
<%@ include file="includes/header.jsp" %>

<body  class="hold-transition login-page">
    <div class="login-box">

        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <div class="login-logo">
                    <img src="dist/img/logo.jpg" alt="Logo" width="300" height="100">
                </div>
                <p class="login-box-msg">Login Here</p>

                <form action="LoginServlet" method="post">

                    <%-- Display error message if it exists --%>

                    <% if (request.getAttribute("errorMessage") != null) {%>
                    <div class="alert alert-danger alert-dismissible">
                        <h5><i class="icon fas fa-ban"></i> Alert!</h5>
                        <p class="error-message"><%= request.getAttribute("errorMessage")%></p>
                    </div>
                    <% }%>


                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="username" placeholder="User Name" required >
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <!-- /.col -->
                        <div class="col-4">
                            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>


                <p class="mb-1">
                    <a href="forgot-password.html">I forgot my password</a>
                </p>

            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
    <!-- /.login-box -->
