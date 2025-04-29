package controllers;

import entities.FormationInterne;
import entities.SessionFormation;
import services.FormationService;
import services.SessionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "SessionFormationController", urlPatterns = {"/sessions/SessionFormationController"})
public class SessionFormationController extends HttpServlet {

    private SessionService sessionService;
    private FormationService formationService;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionService = new SessionService();
        formationService = new FormationService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        try {
            if (op == null) {
                // Création ou mise à jour
                String id = request.getParameter("id");
                int formationId = Integer.parseInt(request.getParameter("formationId"));
                LocalDate date = LocalDate.parse(request.getParameter("date"));
                String formateur = request.getParameter("formateur");

                FormationInterne formation = formationService.findById(formationId);
                SessionFormation session = new SessionFormation(formation, date, formateur);

                if (id == null || id.isEmpty()) {
                    // Création
                    sessionService.create(session);
                    response.sendRedirect("page.jsp?success=create");
                } else {
                    // Mise à jour
                    session.setId(Integer.parseInt(id));
                    sessionService.update(session);
                    response.sendRedirect("page.jsp?success=update");
                }
            } else if (op.equals("delete")) {
                String id = request.getParameter("id");
                sessionService.delete(sessionService.findById(Integer.parseInt(id)));
                response.sendRedirect("page.jsp?success=delete");
            } else if (op.equals("update")) {
                String id = request.getParameter("id");
                SessionFormation session = sessionService.findById(Integer.parseInt(id));
                request.setAttribute("sessionToUpdate", session);
                request.setAttribute("formations", formationService.findAll());
                request.getRequestDispatcher("page.jsp").forward(request, response);
            } else if (op.equals("search")) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue");
                
                List<SessionFormation> sessions = null;
                if (searchType.equals("theme")) {
                    sessions = sessionService.findByTheme(searchValue);
                } else if (searchType.equals("date")) {
                    sessions = sessionService.findByDate(LocalDate.parse(searchValue));
                } else if (searchType.equals("formateur")) {
                    sessions = sessionService.findByFormateur(searchValue);
                }
                
                request.setAttribute("sessions", sessions);
                request.setAttribute("formations", formationService.findAll());
                request.getRequestDispatcher("page.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("page.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initialiser les données nécessaires
        if (request.getParameter("op") == null) {
            request.setAttribute("formations", formationService.findAll());
            request.setAttribute("sessions", sessionService.findAll());
        }
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "SessionFormationController";
    }
}