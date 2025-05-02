package controllers;

import com.google.gson.Gson;
import dao.UserDao;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UserStatsController", urlPatterns = {"/UserStatsController"})
public class UserStatsController extends HttpServlet {

    private final UserDao dao = new UserDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Compter le nombre total d'utilisateurs
        long usersCount = dao.countAll();

        // Créer un objet JSON avec le résultat
        Map<String, Long> result = new HashMap<>();
        result.put("usersCount", usersCount);

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
        return "Statistiques du nombre d'utilisateurs";
    }
}
