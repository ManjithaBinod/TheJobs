<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarRecep.jsp" %>



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
                        <li class="breadcrumb-item active">Job Seekers</li>
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

                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form action="BookSlotsServlet" method="post">
                            <div id="slotContainer">
                                <div class="slotRow">
                                    <input type="date" name="dates[]" required>
                                    <select name="slots[][]" required>
                                        <option value="" disabled selected>Select a slot</option>
                                        <!-- Loop through available slots from the start time to end time -->
                                        <%                        for (int hour = 8; hour <= 16; hour++) {
                                                String startTime = hour + ":00";
                                                String endTime = (hour + 1) + ":00";
                                        %>
                                        <option value="<%= startTime%>-<%= endTime%>">
                                            <%= startTime%> - <%= endTime%>
                                        </option>
                                        <% }%>
                                    </select>
                                </div>
                            </div>
                            <button type="button" onclick="addSlotRow()">New Line</button>
                            <button type="submit">Submit</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </section>

</div>
<!-- /.content-wrapper -->


<%@ include file="includes/footer.jsp" %>