package code;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionChecker {

    public static void checkSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Don't create a new session if it doesn't exist
        if (session == null && !request.getRequestURI().endsWith("/index.jsp")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
