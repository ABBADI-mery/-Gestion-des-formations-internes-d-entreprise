package controllers;

import entities.Client;
import entities.SessionFormation;
import entities.Participation;
import entities.User;
import services.SessionService;
import dao.UserDao;
import dao.SessionFormationDao;
import dao.ParticipationDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientSessionController", urlPatterns = {"/users/ClientSessionController"})
public class ClientSessionController extends HttpServlet {

    private SessionService sessionService;
    private SessionFormationDao sessionFormationDao;
    private ParticipationDao participationDao;
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionService = new SessionService();
        sessionFormationDao = new SessionFormationDao();
        participationDao = new ParticipationDao();
        userDao = new UserDao();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String op = request.getParameter("op");
            System.out.println("Operation: " + op); // Journalisation

            if (op != null && op.equals("search")) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue");

                List<SessionFormation> sessions = null;
                if (searchType.equals("theme")) {
                    sessions = sessionService.findByTheme(searchValue);
                } else if (searchType.equals("date")) {
                    sessions = sessionService.findByDate(java.time.LocalDate.parse(searchValue));
                } else if (searchType.equals("formateur")) {
                    sessions = sessionService.findByFormateur(searchValue);
                }

                request.setAttribute("sessions", sessions);
            } else if (op != null && op.equals("register")) {
                // Gestion de l'inscription
                String sessionId = request.getParameter("sessionId");
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user"); // Récupérer l'attribut user
                Client client = user instanceof Client ? (Client) user : null;

                System.out.println("Session ID: " + sessionId);
                System.out.println("Client: " + (client != null ? client.getEmail() : "null")); // Journalisation

                if (sessionId != null && client != null) {
                    // Récupérer la session de formation
                    SessionFormation sessionFormation = sessionFormationDao.findById(Integer.parseInt(sessionId));

                    if (sessionFormation != null) {
                        // Vérifier si le client est déjà inscrit
                        List<Participation> participations = participationDao.findByClientId(client);
                        boolean alreadyRegistered = participations.stream()
                                .anyMatch(p -> p.getSessionFormation().getId() == Integer.parseInt(sessionId));

                        if (!alreadyRegistered) {
                            // Créer et enregistrer la participation
                            Participation participation = new Participation(sessionFormation, client);
                            participationDao.create(participation);
                            request.setAttribute("message", "Inscription réussie pour la session !");
                        } else {
                            request.setAttribute("error", "Vous êtes déjà inscrit à cette session.");
                        }
                    } else {
                        request.setAttribute("error", "Information de session invalide.");
                    }
                } else {
                    String errorMsg = (sessionId == null ? "ID de session manquant. " : "")
                            + (client == null ? "Veuillez vous connecter en tant que client." : "");
                    request.setAttribute("error", errorMsg);
                }

                // Recharger les sessions pour l'affichage
                request.setAttribute("sessions", sessionService.findAll());
            } else {
                // Par défaut : afficher toutes les sessions
                request.setAttribute("sessions", sessionService.findAll());
            }

            request.getRequestDispatcher("client.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur dans ClientSessionController: " + e.getMessage());
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("client.jsp").forward(request, response);
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
        return "ClientSessionController - Gère l'affichage et l'inscription aux sessions pour les clients";
    }
}
