<%@page import="java.util.Objects"%>
<!DOCTYPE html>
<%@ include file="includes/header.jsp" %>

<body  class="hold-transition login-page">
    <section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class=""></li>
                    <li class=""></li>
                </ol>
            </div>
        </div>
    </div><!-- /.container-fluid -->
</section>
    <div class="login-box">

        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <div class="login-logo">
                    <img src="dist/img/logo.jpg" alt="Logo" width="300" height="100">
                </div>

                <div class="card-body">
                    <a  class="btn btn-danger"  onclick="goBack()">Back</a>
                </div>

                <form action="applicantAddServlet" method="POST">

                    <div class="card-body">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="Enter Name" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" name="address" placeholder="Enter Address" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                        </div>
                        <div class="form-group">
                            <label for="tel">Telephone</label>
                            <input type="text" class="form-control" name="tel" placeholder="Mobile No" required>
                        </div>
                        <div class="form-group">
                            <label for="userName">User Name</label>
                            <input type="text" class="form-control" name="userName" placeholder="Enter User Name" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                        </div>
                    </div>
                    <!-- /.card-body -->

                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>

            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
    <!-- /.login-box -->





    <script>
        function goBack() {
            window.history.back();
        }
    </script>

    
    <% String successMessage = (String) session.getAttribute("successMessage");
        if (Objects.nonNull(successMessage)) {%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.all.min.js"></script>
    <script>
        Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: '<%= successMessage%>',
            showConfirmButton: false,
            timer: 1500
        }).then(function () {
        <%-- Remove the session attribute after displaying the message --%>
        <% session.removeAttribute("successMessage"); %>
        });
    </script>
    <% } %>


    <% String errorMessage = (String) session.getAttribute("errorMessage");
    if (Objects.nonNull(errorMessage)) {%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.all.min.js"></script>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: '<%= errorMessage%>',

        }).then(function () {
        <%-- Remove the session attribute after displaying the message --%>
        <% session.removeAttribute("errorMessage"); %>
        });
    </script>
    <% }%>

