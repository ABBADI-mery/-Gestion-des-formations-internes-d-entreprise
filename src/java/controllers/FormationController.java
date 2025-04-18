package controllers;

import entities.FormationInterne;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "FormationController", urlPatterns = {"/FormationController"})
public class FormationController extends HttpServlet {

    private FormationService fis;

    @Override
    public void init() throws ServletException {
        super.init();
        fis = new FormationService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {
            // Création ou mise à jour
            String id = request.getParameter("id");
            String titre = request.getParameter("titre");
            String theme = request.getParameter("theme");
            int duree = Integer.parseInt(request.getParameter("duree"));

            FormationInterne f = new FormationInterne(titre, theme, duree);

            if (id == null || id.isEmpty()) {
                // Création
                fis.create(f);
            } else {
                // Mise à jour
                f.setId(Integer.parseInt(id));
                fis.update(f);
            }

            response.sendRedirect("formations/page.jsp");

        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            fis.delete(fis.findById(Integer.parseInt(id)));
            response.sendRedirect("formations/page.jsp");

        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            FormationInterne f = fis.findById(Integer.parseInt(id));
            response.sendRedirect("formations/page.jsp?id=" + f.getId() +
                    "&titre=" + f.getTitre() +
                    "&theme=" + f.getTheme() +
                    "&duree=" + f.getDuree());
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
        return "FormationController";
    }
}
