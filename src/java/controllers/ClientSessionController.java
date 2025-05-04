package controllers;

import entities.Client;
import entities.FormationInterne;
import entities.SessionFormation;
import entities.Participation;
import entities.User;
import services.FormationService;
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
import java.util.stream.Collectors;

@WebServlet(name = "ClientSessionController", urlPatterns = {"/users/ClientSessionController"})
public class ClientSessionController extends HttpServlet {

    private SessionService sessionService;
    private SessionFormationDao sessionFormationDao;
    private ParticipationDao participationDao;
    private UserDao userDao;
    private FormationService formationService;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionService = new SessionService();
        sessionFormationDao = new SessionFormationDao();
        participationDao = new ParticipationDao();
        userDao = new UserDao();
        formationService = new FormationService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String op = request.getParameter("op");
            System.out.println("Operation: " + op);

            if (op != null && op.equals("search")) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue") != null ? request.getParameter("searchValue").trim() : "";

                List<FormationInterne> formations = formationService.findAll();
                if (!searchValue.isEmpty() && searchType != null) {
                    formations = formations.stream()
                            .filter(f -> {
                                if (searchType.equals("theme") && f.getTheme() != null) {
                                    return f.getTheme().toLowerCase().contains(searchValue.toLowerCase());
                                } else if (searchType.equals("titre") && f.getTitre() != null) {
                                    return f.getTitre().toLowerCase().contains(searchValue.toLowerCase());
                                }
                                return false;
                            })
                            .collect(Collectors.toList());
                }

                request.setAttribute("formations", formations);
                request.setAttribute("view", "formations");
            } else if (op != null && op.equals("register")) {

                String sessionId = request.getParameter("sessionId");
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");
                Client client = user instanceof Client ? (Client) user : null;

                System.out.println("Session ID: " + sessionId);
                System.out.println("Client: " + (client != null ? client.getEmail() : "null")); // Logging

                if (sessionId != null && client != null) {
                    SessionFormation sessionFormation = sessionFormationDao.findById(Integer.parseInt(sessionId));

                    if (sessionFormation != null) {
                        List<Participation> participations = participationDao.findByClientId(client);
                        boolean alreadyRegistered = participations.stream()
                                .anyMatch(p -> p.getSessionFormation().getId() == Integer.parseInt(sessionId));

                        if (!alreadyRegistered) {
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

                // Reload sessions for the selected formation
                String formationId = request.getParameter("formationId");
                if (formationId != null) {
                    FormationInterne formation = formationService.findById(Integer.parseInt(formationId));
                    if (formation != null) {
                        request.setAttribute("sessions", formation.getSessions());
                        request.setAttribute("selectedFormation", formation);
                        request.setAttribute("view", "sessions");
                    } else {
                        request.setAttribute("view", "formations");
                        request.setAttribute("formations", formationService.findAll());
                    }
                } else {
                    request.setAttribute("view", "formations");
                    request.setAttribute("formations", formationService.findAll());
                }
            } else if (op != null && op.equals("viewSessions")) {

                String formationId = request.getParameter("formationId");
                if (formationId != null) {
                    FormationInterne formation = formationService.findById(Integer.parseInt(formationId));
                    if (formation != null) {
                        request.setAttribute("sessions", formation.getSessions());
                        request.setAttribute("selectedFormation", formation);
                        request.setAttribute("view", "sessions");
                    } else {
                        request.setAttribute("error", "Formation introuvable.");
                        request.setAttribute("view", "formations");
                        request.setAttribute("formations", formationService.findAll());
                    }
                } else {
                    request.setAttribute("error", "ID de formation manquant.");
                    request.setAttribute("view", "formations");
                    request.setAttribute("formations", formationService.findAll());
                }
            } else {

                List<FormationInterne> formations = formationService.findAll();
                System.out.println("Formations loaded: " + (formations != null ? formations.size() : "null"));
                request.setAttribute("formations", formations);
                request.setAttribute("view", "formations");
            }

            request.getRequestDispatcher("client.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur dans ClientSessionController: " + e.getMessage());
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.setAttribute("view", "formations");
            request.setAttribute("formations", formationService.findAll());
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
        return "ClientSessionController - Gère l'affichage des formations, sessions et l'inscription pour les clients";
    }
}
