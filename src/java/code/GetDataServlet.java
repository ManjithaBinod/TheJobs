/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "GetDataServlet", urlPatterns = {"/GetDataServlet"})
public class GetDataServlet extends HttpServlet {

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
            out.println("<title>Servlet GetDataServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetDataServlet at " + request.getContextPath() + "</h1>");
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

        try (PrintWriter out = response.getWriter()) {

            String type = request.getParameter("type");

            DbConnection dbc = new DbConnection();
            Connection connection = dbc.getConnection();
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            String query = "";

            if ("date".equals(type)) {
                int consId = Integer.parseInt(request.getParameter("consId"));
                query = "SELECT date FROM availabilityslot WHERE consId = ? AND date >= CURDATE() GROUP BY date;";

                statement = connection.prepareStatement(query);
                statement.setInt(1, consId);
                resultSet = statement.executeQuery();

                int count = 0;
                StringBuilder html = new StringBuilder();

                html.append("<option value=\"\">Select Date</option>");
                
                while (resultSet.next()) {
                    count++;

                    String date = resultSet.getString("date");
                    html.append("<option value=\"").append(date).append("\">").append(date).append("</option>");

                }
                out.print(html.toString());

            } else if ("time".equals(type)) {
                String selectDate = request.getParameter("selectDate");
                int consId = Integer.parseInt(request.getParameter("consId"));
                query = "SELECT startTime, endTime FROM availabilityslot WHERE consId = ? AND date = ? AND isBooked=0";

                statement = connection.prepareStatement(query);
                statement.setInt(1, consId);
                statement.setString(2, selectDate);
                resultSet = statement.executeQuery();

                int count = 0;
                StringBuilder html = new StringBuilder(); // Create a single StringBuilder

                html.append("<option value=\"0\">Select Time</option>");
                
                while (resultSet.next()) {
                    count++;
                    String startTime = resultSet.getString("startTime");
                    String endTime = resultSet.getString("endTime");
                    String timeSlot = startTime + " - " + endTime;
                    html.append("<option value=\"").append(timeSlot).append("\">").append(timeSlot).append("</option>");

                }
                out.print(html.toString()); // Print the entire HTML content

            }

        } catch (SQLException ex) {
            Logger.getLogger(GetDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GetDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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
