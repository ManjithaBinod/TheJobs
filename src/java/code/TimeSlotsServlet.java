/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import code.DbConnection;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "TimeSlotsServlet", urlPatterns = {"/TimeSlotsServlet"})
public class TimeSlotsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TimeSlotsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TimeSlotsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get array of dates and slots from the form
        String[] dates = request.getParameterValues("dates[]");
        String[] slots = request.getParameterValues("slots[]");

        Connection con = null;
        PreparedStatement preparedStatement = null;
        PreparedStatement ConsPreparedStatement = null;
        ResultSet resultSet = null;

        try {
            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();
            int userId = -1;
            int consultantId = -1;

            HttpSession session = request.getSession(false); // Don't create a new session if not available

            if (session != null) {
                userId = (Integer) session.getAttribute("userId");
            }

            // Getting consultant Id query
            String consQuery = "SELECT consId FROM consultant WHERE userId = ?";
            ConsPreparedStatement = con.prepareStatement(consQuery);
            ConsPreparedStatement.setInt(1, userId);
            resultSet = ConsPreparedStatement.executeQuery();

            if (resultSet.next()) {

                consultantId = resultSet.getInt("consId");

                // Prepare the insert query
                String insertQuery = "INSERT INTO availabilityslot (consId, date, startTime, endTime, isBooked) VALUES (?, ?, ?, ?, ?)";
                preparedStatement = con.prepareStatement(insertQuery);

                // Iterate through the dates and slots
                for (int i = 0; i < dates.length; i++) {
                    String dateStr = dates[i];
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = sdf.parse(dateStr);

                    for (String slot : slots) {
                        String[] times = slot.split("-");
                        String startTimeStr = times[0];
                        String endTimeStr = times[1];

                        // Ensure startTimeStr and endTimeStr are in "HH:mm" format
                        startTimeStr = startTimeStr + ":00";
                        endTimeStr = endTimeStr + ":00";

                        preparedStatement.setInt(1, consultantId); // Set the consultant ID
                        preparedStatement.setDate(2, new java.sql.Date(date.getTime()));
                        preparedStatement.setTime(3, java.sql.Time.valueOf(startTimeStr));
                        preparedStatement.setTime(4, java.sql.Time.valueOf(endTimeStr));
                         preparedStatement.setInt(5, 0);

                        preparedStatement.addBatch(); // Add the batch for batch insertion
                    }
                }

                // Execute the batch
                preparedStatement.executeBatch();

                String successMessage = "Slots Activated successfully";
                request.getSession().setAttribute("successMessage", successMessage);
                response.sendRedirect("availability.jsp"); // Redirect to a success page
            } else {
                // Handle case where no consultant ID is found
                String errorMessage = "Consultant ID not found.";
                request.getSession().setAttribute("errorMessage", errorMessage);
                response.sendRedirect("availability.jsp"); // Redirect to an error page
            }
        } catch (SQLException ex) {
            // Handle SQLException
            ex.printStackTrace(); // Print the exception for debugging
            String errorMessage = "An error occurred while activating slots. Please try again later.";
            request.getSession().setAttribute("errorMessage", errorMessage);
            response.sendRedirect("availability.jsp"); // Redirect to an error page
        } catch (ClassNotFoundException ex) {
            // Handle ClassNotFoundException
            ex.printStackTrace(); // Print the exception for debugging
            String errorMessage = "Internal server error. Please contact the administrator.";
            request.getSession().setAttribute("errorMessage", errorMessage);
            response.sendRedirect("availability.jsp"); // Redirect to an error page
        } catch (ParseException ex) {
            // Handle ParseException
            ex.printStackTrace(); // Print the exception for debugging
            String errorMessage = "Invalid date format. Please select valid dates.";
            request.getSession().setAttribute("errorMessage", errorMessage);
            response.sendRedirect("availability.jsp"); // Redirect to an error page
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                // Handle SQLException while closing resources
                ex.printStackTrace(); // Print the exception for debugging
            }
        }
    }


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
