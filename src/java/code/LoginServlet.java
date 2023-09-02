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
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String enteredPassword = request.getParameter("password");

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        PreparedStatement infoStatement = null;
        ResultSet infoResultSet = null;

        try {

            DbConnection dbc = new DbConnection();
            connection = dbc.getConnection();

            String query = "SELECT userId, password, roleId FROM user WHERE userName = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            resultSet = statement.executeQuery();

            String tableName = null;
            String roleName = null;

            if (resultSet.next()) {
                int userId = resultSet.getInt("userId");
                String storedHashedPassword = resultSet.getString("password");
                int roleId = resultSet.getInt("roleId");

                // Compare the entered password with the stored hashed password using BCrypt
                if (BCrypt.checkpw(enteredPassword, storedHashedPassword)) {
                    // Passwords match, user is authenticated

                    if (roleId == 1) {
                        tableName = "admin";
                        roleName = "Admin Account";

                    } else if (roleId == 2) {
                        tableName = "consultant";
                        roleName = "Consultant Account";

                    } else if (roleId == 3) {
                        tableName = "applicant";
                        roleName = "Job Seeker Account";
                    }

                    String infoQuery = "SELECT * FROM " + tableName + " WHERE userId = ?";

                    infoStatement = connection.prepareStatement(infoQuery);
                    infoStatement.setInt(1, userId);
                    infoResultSet = infoStatement.executeQuery();

                    if (infoResultSet.next()) {
                        int consId = -1;
                        int aplId = -1;

                        String name = infoResultSet.getString("name");
                        String address = infoResultSet.getString("address");
                        String email = infoResultSet.getString("email");
                        String telephone = infoResultSet.getString("telephone");

                        if (roleId == 2) {
                            consId = infoResultSet.getInt("consId");
                        } else if (roleId == 3) {
                            aplId = infoResultSet.getInt("aplId");
                        }

                        // Set user role in the session
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", userId);
                        session.setAttribute("roleId", roleId);
                        session.setAttribute("name", name);
                        session.setAttribute("roleName", roleName);
                        session.setAttribute("address", address);
                        session.setAttribute("email", email);
                        session.setAttribute("telephone", telephone);
                        session.setAttribute("consId", consId);
                        session.setAttribute("aplId", aplId);
                    }

                    // Redirect to user dashboard based on role
                    response.sendRedirect("dashboard.jsp");

                } else {
                    // Passwords do not match, authentication failed
                    String errorMessage = "Invalid username or password";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                // User not found, authentication failed
                String errorMessage = "Invalid username or password";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Handle database error
            response.sendRedirect("index.jsp?error=database_error");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
                if (resultSet != null) {
                    resultSet.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    // Simulate database validation
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
