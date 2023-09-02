<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.json.JsonArrayBuilder, javax.json.Json" %>
<%@ page import="java.sql.*" %>



<%
    String consultantIdStr = request.getParameter("consultantId");
    int consultantId = Integer.parseInt(consultantIdStr);

    // Replace with your actual database connection code
    String jdbcUrl = "jdbc:mysql://localhost:3306/yourdb";
    String username = "yourusername";
    String password = "yourpassword";
    Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

    String query = "SELECT DISTINCT date FROM availabilityslot WHERE consultant_id = ?";
    PreparedStatement statement = connection.prepareStatement(query);
    statement.setInt(1, consultantId);
    ResultSet resultSet = statement.executeQuery();

    List<String> datesList = new ArrayList<>();
    while (resultSet.next()) {
        datesList.add(resultSet.getString("date"));
    }

    JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
    for (String date : datesList) {
        jsonArrayBuilder.add(date);
    }

    String datesArray = jsonArrayBuilder.build().toString();
    
    resultSet.close();
    statement.close();
    connection.close();

   
%>

<script>
    var datesArray = <%= datesArray %>;
    // Now you can use the JavaScript datesArray variable for your logic
</script>