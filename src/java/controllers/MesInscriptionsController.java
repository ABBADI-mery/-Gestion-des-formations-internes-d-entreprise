package controllers;

import entities.Client;
import entities.Participation;
import entities.SessionFormation;
import entities.User;
import dao.ParticipationDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "MesInscriptionsController", urlPatterns = {"/users/MesInscriptionsController"})
public class MesInscriptionsController extends HttpServlet {

    private ParticipationDao participationDao;

    @Override
    public void init() throws ServletException {
        super.init();
        participationDao = new ParticipationDao();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            Client client = user instanceof Client ? (Client) user : null;

            if (client == null) {
                response.sendRedirect("../login.jsp");
                return;
            }

            // Vérifier l'opération
            String op = request.getParameter("op");
            if ("cancel".equals(op)) {
                String sessionId = request.getParameter("sessionId");
                if (sessionId != null) {
                    // Trouver la participation à supprimer
                    List<Participation> participations = participationDao.findByClientId(client);
                    Participation participation = participations.stream()
                            .filter(p -> p.getSessionFormation().getId() == Integer.parseInt(sessionId))
                            .findFirst()
                            .orElse(null);

                    if (participation != null) {
                        participationDao.delete(participation);
                        request.setAttribute("message", "Inscription annulée avec succès !");
                    } else {
                        request.setAttribute("error", "Inscription introuvable.");
                    }
                } else {
                    request.setAttribute("error", "ID de session manquant.");
                }
            }

            // Récupérer les participations du client
            List<Participation> participations = participationDao.findByClientId(client);
            // Extraire les sessions de formation des participations
            List<SessionFormation> sessions = participations.stream()
                    .map(Participation::getSessionFormation)
                    .collect(Collectors.toList());

            // Transmettre les sessions à la JSP
            request.setAttribute("sessions", sessions);
            request.getRequestDispatcher("mesInscriptions.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur dans MesInscriptionsController: " + e.getMessage());
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("mesInscriptions.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "MesInscriptionsController - Affiche et gère les sessions auxquelles le client est inscrit";
    }
}