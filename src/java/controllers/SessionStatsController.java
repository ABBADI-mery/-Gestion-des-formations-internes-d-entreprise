package controllers;

import com.google.gson.Gson;
import dao.SessionFormationDao;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SessionStatsController", urlPatterns = {"/SessionStatsController"})
public class SessionStatsController extends HttpServlet {

    private final SessionFormationDao dao = new SessionFormationDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String statType = request.getParameter("statType");
        Map<String, Object> result = new HashMap<>();

        switch (statType != null ? statType : "") {
            case "countAll":
                result.put("sessionsCount", dao.countAll());
                break;
            case "participantsBySession":
                List<Object[]> stats = dao.countParticipantsBySession();
                
                Map<String, Integer> participantsMap = new HashMap<>();
                for (Object[] stat : stats) {
                    participantsMap.put(stat[0].toString(), Integer.parseInt(stat[1].toString()));
                }
                result.put("participantsBySession", participantsMap);
                break;
            default:
                result.put("error", "Type de statistique non spécifié ou non pris en charge");
                break;
        }

        // Sérialiser en JSON
        String json = new Gson().toJson(result);

        // Envoyer la réponse
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
        return "Statistiques sur les sessions de formation";
    }
}
