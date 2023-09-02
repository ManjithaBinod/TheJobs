/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Security;
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
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author MANJITHA
 */
@WebServlet(name = "AppointmentAddServlet", urlPatterns = {"/AppointmentAddServlet"})
public class AppointmentAddServlet extends HttpServlet {

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
            out.println("<title>Servlet AppointmentAddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppointmentAddServlet at " + request.getContextPath() + "</h1>");
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
    private void sendEmail(String recipient, String subject, String content) throws MessagingException {
        // Set up properties for the email session
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        //props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "sandbox.smtp.mailtrap.io");
        props.put("mail.smtp.port", "587"); // Use the appropriate port
        // props.put("mail.smtp.ssl.protocols","TLSv1.2");

        Security.setProperty("jdk.tls.client.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "*");

        // Authenticate using your email credentials
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("8143dbb44de950", "7e9a1b4cda5d5e");
            }
        });

        // Create and send the email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("8143dbb44de950"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int consId = Integer.parseInt(request.getParameter("consultantSelect"));
        String dateSelect = request.getParameter("dateSelect");
        String timeSlotSelect = request.getParameter("timeSlotSelect");

        int aplId = -1;
        String email = null;

        HttpSession session = request.getSession(false); // Don't create a new session if not available

        if (session != null) {
            aplId = (Integer) session.getAttribute("aplId");
            email = (String) session.getAttribute("email");
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;
        PreparedStatement statementCheck = null;
        ResultSet resultSetCheck = null;
        Connection con = null;

        try {

            DbConnection dbc = new DbConnection();
            con = dbc.getConnection();
            int slotId = 0;
            int booked = -1;

            String queryCheck = "SELECT * FROM availabilityslot WHERE consId = ? AND date = ? AND startTime = ?";
            statementCheck = con.prepareStatement(queryCheck);
            statementCheck.setInt(1, consId);
            statementCheck.setString(2, dateSelect);
            statementCheck.setString(3, timeSlotSelect);

            resultSetCheck = statementCheck.executeQuery();

            if (resultSetCheck.next()) {
                slotId = resultSetCheck.getInt("slotId");
                booked = resultSetCheck.getInt("isBooked");
            }
             System.out.println(slotId);

            if (consId != -1 && dateSelect != null && !dateSelect.isEmpty() && timeSlotSelect != null && !timeSlotSelect.isEmpty()) {

            //    if (booked == 0) {

                    // Insert into admin table using the retrieved user ID
                    String query = "INSERT INTO appointment (aplId, consId, date, time) VALUES (?, ?, ?, ?)";
                    statement = con.prepareStatement(query);
                    statement.setInt(1, aplId);
                    statement.setInt(2, consId);
                    statement.setString(3, dateSelect);
                    statement.setString(4, timeSlotSelect);

                    if (statement.executeUpdate() > 0) {
                        
                       

                        query = "UPDATE availabilityslot SET isBooked = ? WHERE slotId = ?";
                        statement = con.prepareStatement(query);
                        statement.setInt(1, 1);
                        statement.setInt(2, slotId);
                        statement.executeUpdate();

                        String successMessage = "Appointment Added Successfully";
                        request.getSession().setAttribute("successMessage", successMessage); // Store in session

//                    // Email sending part
                        String recipientEmail = email; // recipient's email address
                        String emailSubject = "Appointment Confirmation";
                        String emailContent = "Your appointment has been successfully booked.";

                        sendEmail(recipientEmail, emailSubject, emailContent);

                        response.sendRedirect("bookAppointment.jsp");
                    } else {
                        String errorMessage = "Something went wrong !";
                        request.getSession().setAttribute("errorMessage", errorMessage); // Store in session
                        response.sendRedirect("bookAppointment.jsp");
                    }
//                } else {
//                    String errorMessage = "Slot Already Bokked!";
//                    request.getSession().setAttribute("errorMessage", errorMessage); // Store in session
//                    response.sendRedirect("bookAppointment.jsp");
//                }

            } else {
                String errorMessage = "Please select all 3 fields";
                request.getSession().setAttribute("errorMessage", errorMessage); // Store in session
                response.sendRedirect("bookAppointment.jsp");

            }

        } catch (SQLException e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            out.println("Error while connecting to the database");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(AppointmentAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }

                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
