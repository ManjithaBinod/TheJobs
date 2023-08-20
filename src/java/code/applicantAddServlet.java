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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "applicantAddServlet", urlPatterns = {"/applicantAddServlet"})
public class applicantAddServlet extends HttpServlet {

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
            out.println("<title>Servlet applicantAddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet applicantAddServlet at " + request.getContextPath() + "</h1>");
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
        PreparedStatement userStatement = null;
        PreparedStatement adminStatement = null;
        PreparedStatement nameStatement = null;
        ResultSet resultSet = null;
        Connection con = null;

        try {

            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();

            // Insert into seekers table 
            String adminQuery = "INSERT INTO seekers (name, address, email, telephone) VALUES (?, ?, ?, ?)";
            adminStatement = con.prepareStatement(adminQuery);
            adminStatement.setString(1, name);
            adminStatement.setString(2, address);
            adminStatement.setString(3, email);
            adminStatement.setString(4, tel);
            adminStatement.executeUpdate();

            String successMessage = "Applicant Added Successfully";
            request.getSession().setAttribute("successMessage", successMessage); // Store in session

            response.sendRedirect("applicant.jsp");

        } catch (SQLException e) {
            PrintWriter out = response.getWriter();
            out.println("Error while connecting to the database");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (userStatement != null) {
                    userStatement.close();
                }
                if (adminStatement != null) {
                    adminStatement.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        PrintWriter out = response.getWriter();
        out.println("<html><body><b>Successfully Inserted"
                + "</b></body></html>");

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