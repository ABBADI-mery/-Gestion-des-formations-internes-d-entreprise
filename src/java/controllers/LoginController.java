package controllers;

import entities.Admin;
import entities.Client;
import entities.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.UserService;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("motDePasse");

        if (email.isEmpty() || password.isEmpty()) {
            sendError(request, response, "Email et mot de passe doivent être remplis.");
            return;
        }

        try {
            User u = us.findByEmail(email);
            
            if (u == null) {
                sendError(request, response, "Email non trouvé");
                return;
            }
            
            if (!password.equals(u.getMotDePasse())) {
                sendError(request, response, "Mot de passe incorrect");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", u);

            // Redirection selon le type d'utilisateur
            if (u instanceof Admin) {
                response.sendRedirect("users/admin.jsp");
            } else if (u instanceof Client) {
                response.sendRedirect("users/client.jsp");
            } else {
                sendError(request, response, "Type d'utilisateur inconnu");
            }
            
        } catch (Exception e) {
            sendError(request, response, "Erreur système: " + e.getMessage());
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message) 
            throws ServletException, IOException {
        request.setAttribute("erreur", message);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Controller";
    }
}