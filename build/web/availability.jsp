<%@page import="java.util.Objects"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navjsp.jsp" %>
<%@ include file="includes/sideBarCons.jsp" %>

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
                            <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active">Set Availability</li>
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

                            <!-- /.card-header -->
                            <div class="card-header">
                                <h3 class="card-title">Select Dates and Time Slots</h3>
                            </div>


                        </div>



                       <form action="TimeSlotsServlet" method="post">
                            <div id="slotContainer">
                                <div class="slotRow mb-2">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <input type="date" class="form-control" name="dates[]" required>
                                        </div>
                                        <div class="col-md-6">
                                            <select class="form-control" name="slots[]" multiple required>
                                                <option value="" disabled selected>Select a slot</option>
                                                <!-- Loop through available slots from the start time to end time -->
                                                <%  for (int hour = 8; hour <= 16; hour++) {
                                                        String startTime = hour + ":00";
                                                        String endTime = (hour + 1) + ":00";
                                                %>
                                                <option value="<%= startTime%>-<%= endTime%>">
                                                    <%= startTime%> - <%= endTime%>
                                                </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <br>
                                            <button type="button" class="btn btn-danger btn-remove-line">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="addSlotRow()">Add Another Date</button>
                            <button type="submit" class="btn btn-success">Submit</button>
                        </form>

                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- /.content-wrapper -->

<%@ include file="includes/footer.jsp" %>


<script>
    function handleCancelClick(event) {
        // Remove the closest parent slotRow element
        event.target.closest('.slotRow').remove();
    }

    // Add event listener to all "Cancel" buttons
    const cancelButtons = document.querySelectorAll('.btn-remove-line');
    cancelButtons.forEach(button => {
        button.addEventListener('click', handleCancelClick);
    });
    function addSlotRow() {
        var slotRow = document.createElement("div");
        slotRow.className = "slotRow mb-2";
        slotRow.innerHTML = `
                    <div class="row">
                    <div class="col-md-4">
                    <input type="date" class="form-control" name="dates[]" required>
                </div>
                <div class="col-md-6">
                    <select class="form-control" name="slots[][]" multiple required>
                        <option value="" disabled selected>Select a slot</option>
                        <!-- Loop through available slots from the start time to end time -->
    <%
        for (int hour = 8; hour <= 16; hour++) {
            String startTime = hour + ":00";
            String endTime = (hour + 1) + ":00";
    %>
                        <option value="<%= startTime%>-<%= endTime%>">
    <%= startTime%> - <%= endTime%>
                        </option>
    <% }%>
                    </select>
                </div>
                <div class="col-md-2">
                    <br>
                    <button type="button" class="btn btn-danger btn-remove-line">Close</button>
                </div>
            </div>
        `;

        slotRow.querySelector('.btn-remove-line').addEventListener('click', handleCancelClick);

        document.getElementById("slotContainer").appendChild(slotRow);
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

