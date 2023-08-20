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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "applicantDelServlet", urlPatterns = {"/applicantDelServlet"})
public class applicantDelServlet extends HttpServlet {

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
            out.println("<title>Servlet applicantDelServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet applicantDelServlet at " + request.getContextPath() + "</h1>");
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

        int userId = Integer.parseInt(request.getParameter("userId"));

        Connection con = null;
        try {
            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();
            con.setAutoCommit(false); // Start a transaction

            // Delete from job seekers table
            String deleteConsultantQuery = "DELETE FROM seekers WHERE skId = ?";
            PreparedStatement deleteConsultantStatement = con.prepareStatement(deleteConsultantQuery);
            deleteConsultantStatement.setInt(1, userId);
            int rowsAffectedConsultant = deleteConsultantStatement.executeUpdate();

            if ( rowsAffectedConsultant > 0) {
                con.commit(); // Commit the transaction
                String successMessage = "Applicant Deleted Successfully";
                request.getSession().setAttribute("successMessage", successMessage);
            } else {
                // Rollback the transaction if deletion failed
                con.rollback();
                String errorMessage = "Deletion Failed";
                request.getSession().setAttribute("errorMessage", errorMessage);
            }

            response.sendRedirect("applicant.jsp");
        } catch (SQLException ex) {
            // Handle exceptions and rollback the transaction
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // Handle exception
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            // Handle exceptions
            ex.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true); // Reset auto-commit
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
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
        processRequest(request, response);
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
