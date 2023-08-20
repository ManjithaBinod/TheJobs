<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarAdmin.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="code.DbConnection"%>

<%// Retrieve userId from the query parameter
    int userId = Integer.parseInt(request.getParameter("userId"));

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    DbConnection dbc = new DbConnection();
    connection = dbc.getConnection();
    String name = null;
    String address = null;
    String email = null;
    String telephone = null;
    int useerId = -1;

    String query = "SELECT * FROM consultant WHERE userId = ?";
    statement = connection.prepareStatement(query);
    statement.setInt(1, userId);
    resultSet = statement.executeQuery();

    if (resultSet.next()) {
        name = resultSet.getString("name");
        address = resultSet.getString("address");
        email = resultSet.getString("email");
        telephone = resultSet.getString("telephone");
        userId = resultSet.getInt("userId");
    }


%>


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
                            <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active">Consultants</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2"></div>
                <!-- left column -->
                <div class="col-md-8">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Edit Consultant : <b> <%= name%> </b></h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form action="ConsultantEditServlet" method="POST">
                            <div class="card-body">
                                <div class="form-group">
                                    <input type="hidden" name="userId" required value="<%= userId%>" >
                                    <label for="name">Name</label>
                              
                                    <input type="text" class="form-control" name="name" id="name" placeholder="Enter Name" required value="<%= name%>" >
                                </div>


                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" name="address" placeholder="Enter Address" required value="<%= address%>" >
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" class="form-control" name="email" placeholder="Enter email" required value="<%= email%>" >
                                </div>
                                <div class="form-group">
                                    <label for="tel">Telephone</label>
                                    <input type="text" class="form-control" name="tel" placeholder="Mobile No" required value="<%= telephone%>" >
                                </div>
                            </div>
                            <!-- /.card-body -->

                            <div class="card-footer">
                                <button type="submit" class="btn btn-primary">Edit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>
<!-- /.content-wrapper -->











<%@ include file="includes/footer.jsp" %>