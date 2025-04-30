package controllers;

import entities.Client;
import entities.SessionFormation;
import services.SessionService;
import services.ParticipationService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientController", urlPatterns = {"/ClientController"})
public class ClientController extends HttpServlet {

    private SessionService sessionService;
    private ParticipationService participationService;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionService = new SessionService();
        participationService = new ParticipationService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("client");

        // Redirection si client non connecté
        if (client == null) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        try {
            // Récupérer toutes les sessions disponibles
            List<SessionFormation> sessions = sessionService.findAllAvailableSessions();
            
            // Envoyer les sessions à la JSP
            request.setAttribute("sessions", sessions);
            request.getRequestDispatcher("/client/sessions.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Erreur de chargement des sessions");
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
        processRequest(request, response);
    }
}