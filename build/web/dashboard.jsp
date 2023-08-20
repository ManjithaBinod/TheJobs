
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>



<%    int roleId = (int) session.getAttribute("roleId");

    if (roleId == 1) {%>
<%@ include file="includes/sideBarAdmin.jsp" %>
<% } else if (roleId == 2) { %>
<%@ include file="includes/sideBarCons.jsp" %>
<%} else if (roleId == 3) {%> 
<%@ include file="includes/sideBarRecep.jsp" %>
<% } %>





<div class="wrapper">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">

                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">User Profile</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3"></div>

                    <div class="col-md-6">

                        <!-- Profile Image -->
                        <div class="card card-primary card-outline">
                            <div class="card-body box-profile">
                                <div class="text-center">
<!--                                    <img class="profile-user-img img-fluid img-circle"
                                         src="dist/img/user4-128x128.jpg"
                                         alt="User profile picture">-->
                                </div>

                                <h3 class="profile-username text-center">${sessionScope.name}</h3>

                                <p class="text-muted text-center">${sessionScope.roleName}</p>

                                <ul class="list-group list-group-unbordered mb-3">
                                    <li class="list-group-item">
                                        <b>Address</b> <a class="float-right">${sessionScope.address}</a>
                                    </li>
                                    <li class="list-group-item">
                                        <b>E-mail</b> <a class="float-right">${sessionScope.email}</a>
                                    </li>
                                    <li class="list-group-item">
                                        <b>Telephone</b> <a class="float-right">${sessionScope.telephone}</a>
                                    </li>
                                </ul>


                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->


                    </div>
                    <!-- /.col -->

                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>

<%@ include file="includes/footer.jsp" %>