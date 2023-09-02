<%@page import="java.util.Objects"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarCons.jsp" %>
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
                            <li class="breadcrumb-item active">Check Availability</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>




        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Available Dates and Time</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time Slots</th>

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
                           
                            String query = "SELECT date, GROUP_CONCAT(CONCAT(startTime, ' - ', endTime)) AS timeSlots FROM availabilityslot WHERE consId = ? GROUP BY date;";
                            statement = connection.prepareStatement(query);
                            statement.setInt(1, consId);
                            resultSet = statement.executeQuery();
                            int count = 0;
                            while (resultSet.next()) {
                                count++;
                                String date = resultSet.getString("date");
                                String timeSlotsStr = resultSet.getString("timeSlots");
                                String[] timeSlots = timeSlotsStr.split(",");
                        %>

                        <tr>
                            <td><%= date%></td>
                            <td>
                                <select class="form-control" name="slots[]" >
                                    <% for (String slot : timeSlots) {%>
                                    <option value="<%= slot%>"><%= slot%></option>
                                    <% } %>
                                </select>
                            </td>
                        </tr>

                        <%
                            }
                        %>
                    </tbody>

                    <tfoot>
                        <tr>
                            <th>Date</th>
                            <th>Time Slots</th>

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
            "responsive": true, "lengthChange": false, "autoWidth": false, "paging": true,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

    });

</script>



