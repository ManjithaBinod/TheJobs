<%@page import="java.util.Objects"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="code.DbConnection"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarCons.jsp" %>


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
                            <li class="breadcrumb-item active">Appointment Report</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>




        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Appointments History Report</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Client</th>
                            <th>Email</th>
                            <th>Date</th>
                            <th>Time</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%        
                            Connection connection = null;
                            PreparedStatement statement = null;
                            ResultSet resultSet = null;
                            int consId = -1;

                            DbConnection dbc = new DbConnection();
                            connection = dbc.getConnection();
                            
                            consId = (int) session.getAttribute("consId");
                           
                            String query = "SELECT * FROM appointment LEFT JOIN applicant ON applicant.aplId = appointment.aplId WHERE appointment.consId = ? AND appointment.date < CURDATE() ORDER BY appointment.date";
                            statement = connection.prepareStatement(query);
                            statement.setInt(1, consId);
                            resultSet = statement.executeQuery();
                            int count = 0;
                            while (resultSet.next()) {
                                count++;
                                String applicant = resultSet.getString("applicant.name");
                                String email = resultSet.getString("applicant.email");
                                String date = resultSet.getString("appointment.date");
                                String time = resultSet.getString("appointment.time");
                               
                        %>

                        <tr>
                            <td><%= applicant%></td>
                            <td><%= email%></td>
                            <td><%= date%></td>
                            <td><%= time%></td>
                            
                        </tr>

                        <%
                            }
                        %>
                    </tbody>

                    <tfoot>
                        <tr>
                            <th>Client</th>
                            <th>Email</th>
                            <th>Date</th>
                            <th>Time</th>

                        </tr>
                    </tfoot>
                </table>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->

    </div>
</div>


                        
<%@ include file="includes/footer.jsp" %>

<script>
    
    $(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,"paging": true,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

    });

</script>



