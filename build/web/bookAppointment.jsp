<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarApl.jsp" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="code.DbConnection"%>

<!DOCTYPE html>
<div class="wrapper">
    <!-- Sidebar, Header, and Content here -->

    <div class="content-wrapper">

        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">

                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active">Appointment Booking</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <section class="content">
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
                            <th>Country</th>
                            <th>Job Type</th>
                          
                        </tr>
                    </thead>
                    <tbody>

                        <%                            Connection connection = null;
                            PreparedStatement statement = null;
                            ResultSet resultSet = null;

                            DbConnection dbc = new DbConnection();
                            connection = dbc.getConnection();

                            String query = "SELECT * FROM consultant";
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
                            <td><%= resultSet.getString("country")%></td>
                            <td><%= resultSet.getString("jobType")%></td>
                           
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
                            <th>Country</th>
                            <th>Job Type</th>
                           
                        </tr>
                    </tfoot>
                </table>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
        </section>

        <form action="AppointmentAddServlet" method="POST">
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Select Consultant</h3>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="consultantSelect">Consultant</label>

                                        <select id="consultantSelect" name="consultantSelect" class="form-control">
                                            <option value="-1" Selected >Select a consultant</option>
                                            <%
                                                connection = null;
                                                statement = null;
                                                resultSet = null;

                                                dbc = new DbConnection();
                                                connection = dbc.getConnection();

                                                query = "SELECT * FROM consultant";
                                                statement = connection.prepareStatement(query);
                                                resultSet = statement.executeQuery();

                                                while (resultSet.next()) {

                                                    int consId = resultSet.getInt("consId");
                                                    String name = resultSet.getString("name");
                                            %>

                                            <option value= <%= consId%> ><%= name%></option>
                                            <% }%>

                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Select Date</h3>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="dateSelect">Date</label>
                                        <select id="dateSelect" name ="dateSelect" class="form-control">
                                            <option value="" selected disabled>Select a date</option>
                                            <!-- Populate dates dynamically based on selected consultant using AJAX -->
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Select Time Slot</h3>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="timeSlotSelect">Time Slot</label>
                                        <select id="timeSlotSelect" name="timeSlotSelect" class="form-control">
                                            <option value="" selected disabled>Select a time slot</option>
                                            <!-- Populate time slots dynamically based on selected date using AJAX -->
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">Submit</button>

                </div>
            </section>

        </form>

        
    </div>

    <!-- Include AdminLTE scripts and other scripts -->


    <%@ include file="includes/footer.jsp" %>

    <script>
        $(document).ready(function () {
            jQuery('#consultantSelect').change(function () {
                var id = jQuery(this).val();
                jQuery.ajax({
                    type: 'post',
                    url: 'GetDataServlet',
                    data: 'consId=' + id + '&type=date',

                    success: function (result) {

                        $('#dateSelect').empty().append(result);
                    }
                });

            });

            jQuery('#dateSelect').change(function () {
                var consId = $('#consultantSelect').val(); // Get the selected consultant ID
                var selectDate = jQuery(this).val();

                jQuery.ajax({
                    type: 'post',
                    url: 'GetDataServlet',
                    data: 'consId=' + consId + '&selectDate=' + selectDate + '&type=time',

                    success: function (result) {

                        jQuery('#timeSlotSelect').empty().append(result);
                    }
                });

            });



        });
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
    <script>

        $(function () {
            $("#example1").DataTable({
                "responsive": true, "lengthChange": false, "autoWidth": false, "paging": true,
                
            }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        });

    </script>
