<%@page import="java.util.Objects"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarAdmin.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="code.DbConnection"%>


<div class="wrapper">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">

        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">

                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active">Receptionists</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <div class="row">
            <div class="col-md-5">

            </div>
            <div class="col-md-2">
                <a type="button" data-toggle="modal" data-target="#modal-default" href="#" class="btn btn-block bg-gradient-primary btn-md">Add Receptionist</a> <br>

            </div>            
            <div class="col-md-5"></div>
        </div>

        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
               
            </div>


        </div>




        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Consultant List</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Address</th>
                            <th>E-mail(s)</th>
                            <th>Telephone</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            Connection connection = null;
                            PreparedStatement statement = null;
                            ResultSet resultSet = null;

                            DbConnection dbc = new DbConnection();
                            connection = dbc.getConnection();

                            String query = "SELECT * FROM receptionist";
                            statement = connection.prepareStatement(query);
                            resultSet = statement.executeQuery();
                            int count = 0;
                            while (resultSet.next()) {
                                count++;
                        %>

                        <tr>
                            <td><%= resultSet.getString("name")%></td>
                            <td><%= resultSet.getString("address")%>
                            </td>
                            <td><%= resultSet.getString("email")%></td>
                            <td><%= resultSet.getString("telephone")%></td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-info">Action</button>
                                    <button type="button" class="btn btn-info dropdown-toggle dropdown-icon" data-toggle="dropdown" aria-expanded="false">
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu" role="menu" style="">
                                        <a class="dropdown-item edit-link" href="receptionistEdit.jsp?userId=<%= resultSet.getInt("userId")%>" >Edit</a>
                                        <a class="dropdown-item"  href="RecepDelServlet?userId=<%= resultSet.getInt("userId")%>" onclick="return confirmWithSweetAlert(this)">Delete</a>

                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th>Name</th>
                            <th>Address</th>
                            <th>E-mail(s)</th>
                            <th>Telephone</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->

    </div>
</div>


<!-- Consultant Add Modal -->
<div class="modal fade" id="modal-default">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Add Receptionist</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form action="RecepAddServlet" method="POST">

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
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- End Consultant Add Modal -->



<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" aria-labelledby="modal-edit-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>




<%@ include file="includes/footer.jsp" %>

<script>
    $(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

    });

</script>

<script>
    function confirmWithSweetAlert(link) {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                // Proceed with deletion by redirecting to the link's href
                window.location.href = link.href;
            }
        });

        // Prevent the link from being followed immediately
        return false;
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
    if (Objects.nonNull(errorMessage)) { %>
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

