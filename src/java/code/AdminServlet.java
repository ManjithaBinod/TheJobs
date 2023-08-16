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

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})

public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String tel = request.getParameter("tel");
        String password = request.getParameter("password");
        String userName = request.getParameter("userName");
        PreparedStatement userStatement = null;
        PreparedStatement adminStatement = null;
        Connection con = null;

        // Hash the password using bcrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try {

            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();

            // Insert into user table
            String userQuery = "INSERT INTO user (userName, password, roleId) VALUES (?, ?, ?)";
            userStatement = con.prepareStatement(userQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            userStatement.setString(1, userName);
            userStatement.setString(2, hashedPassword);
            userStatement.setInt(3, 1);
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
                String adminQuery = "INSERT INTO admin (userId, name, address, email, telephone) VALUES (?, ?, ?, ?, ?)";
                adminStatement = con.prepareStatement(adminQuery);
                adminStatement.setInt(1, userId);
                adminStatement.setString(2, name);
                adminStatement.setString(3, address);
                adminStatement.setString(4, email);
                adminStatement.setString(5, tel);
                adminStatement.executeUpdate();

                response.sendRedirect("admin.jsp"); // Redirect back to admin.jsp
            } else {
                PrintWriter out = response.getWriter();
                out.println("Failed to retrieve user ID.");
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
    }
}
