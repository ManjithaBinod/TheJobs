/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "ConsultantEditServlet", urlPatterns = {"/ConsultantEditServlet"})
public class ConsultantEditServlet extends HttpServlet {

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
            out.println("<title>Servlet ConsultantEditServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConsultantEditServlet at " + request.getContextPath() + "</h1>");
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

    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String tel = request.getParameter("tel");
    String country = request.getParameter("country");
    String jobs = request.getParameter("jobs");
    String userIdStr = request.getParameter("userId");
    int userId = Integer.parseInt(userIdStr);

    PreparedStatement preparedStatement = null;
    Connection con = null;

    try {
        DbConnection dbc = new DbConnection();
        con = dbc.getConnection();

        // Use placeholders in the query and set values using prepared statement
        String query = "UPDATE consultant SET name = ?, address = ?, email = ?, telephone = ?, country = ?, jobType = ? WHERE userId = ?";
        preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, address);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, tel);
        preparedStatement.setString(5, country);
        preparedStatement.setString(6, jobs);
        preparedStatement.setInt(7, userId);

        preparedStatement.executeUpdate();

        String successMessage = "Consultant Edited Successfully";
        request.getSession().setAttribute("successMessage", successMessage); // Store in session
        response.sendRedirect("consultant.jsp");

    } catch (SQLException ex) {
        Logger.getLogger(ConsultantEditServlet.class.getName()).log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(ConsultantEditServlet.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsultantEditServlet.class.getName()).log(Level.SEVERE, null, ex);
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
