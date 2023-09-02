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
@WebServlet(name = "ConsultantAddSeervlet", urlPatterns = {"/ConsultantAddSeervlet"})
public class ConsultantAddSeervlet extends HttpServlet {

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
            out.println("<title>Servlet ConsultantAddSeervlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConsultantAddSeervlet at " + request.getContextPath() + "</h1>");
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
        String password = request.getParameter("password");
        String userName = request.getParameter("userName");
        PreparedStatement userStatement = null;
        PreparedStatement adminStatement = null;
        PreparedStatement nameStatement = null;
        ResultSet resultSet = null;
        Connection con = null;

        // Hash the password using bcrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try {

            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();

            //check user name if already exsits
            String nameQuery = "SELECT * FROM user WHERE userName = ? ";
            nameStatement = con.prepareStatement(nameQuery);
            nameStatement.setString(1, userName);
            resultSet = nameStatement.executeQuery();

            if (resultSet.next()) {

                String errorMessage = "User name already exists !";
                request.getSession().setAttribute("errorMessage", errorMessage); // Store in session

                response.sendRedirect("consultant.jsp");
                
            } else {

                // Insert into user table
                String userQuery = "INSERT INTO user (userName, password, roleId) VALUES (?, ?, ?)";
                userStatement = con.prepareStatement(userQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                userStatement.setString(1, userName);
                userStatement.setString(2, hashedPassword);
                userStatement.setInt(3, 2);
                userStatement.executeUpdate();

                int userId = -1;

                // Get the auto-generated user ID
                try (ResultSet generatedKeys = userStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        userId = generatedKeys.getInt(1);
                    }
                }

                if (userId != -1) {
                    // Insert into admin table using the retrieved user ID
                    String adminQuery = "INSERT INTO consultant (userId, name, address, email, telephone, country, jobType) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    adminStatement = con.prepareStatement(adminQuery);
                    adminStatement.setInt(1, userId);
                    adminStatement.setString(2, name);
                    adminStatement.setString(3, address);
                    adminStatement.setString(4, email);
                    adminStatement.setString(5, tel);
                    adminStatement.setString(6, country);
                    adminStatement.setString(7, jobs);
                    adminStatement.executeUpdate();

                    String successMessage = "Consultant Added Successfully";
                    request.getSession().setAttribute("successMessage", successMessage); // Store in session

                    response.sendRedirect("consultant.jsp");

                } else {
                    PrintWriter out = response.getWriter();
                    out.println("Failed to retrieve user ID.");
                }
            }

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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
