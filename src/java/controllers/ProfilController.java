package controllers;

import entities.Client;
import entities.User;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfilController", urlPatterns = {"/users/ProfilController"})
public class ProfilController extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
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
            if ("update".equals(op)) {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");

                // Validation pour le mot de passe si fourni
                if (currentPassword != null && !currentPassword.isEmpty()) {
                    // Vérifier le mot de passe actuel
                    if (!currentPassword.equals(client.getMotDePasse())) {
                        request.setAttribute("error", "Mot de passe actuel incorrect.");
                    } else if (newPassword == null || newPassword.trim().isEmpty()) {
                        request.setAttribute("error", "Le nouveau mot de passe ne peut pas être vide.");
                    } else {
                        // Mettre à jour le mot de passe
                        client.setMotDePasse(newPassword);
                        userDao.update(client);
                        session.setAttribute("user", client); // Mettre à jour la session
                        request.setAttribute("message", "Mot de passe mis à jour avec succès !");
                    }
                } else {
                    request.setAttribute("error", "Veuillez entrer votre mot de passe actuel pour effectuer une mise à jour.");
                }
            }

            // Transmettre le client à la JSP pour affichage
            request.setAttribute("client", client);
            request.getRequestDispatcher("profil.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur dans ProfilController: " + e.getMessage());
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("profil.jsp").forward(request, response);
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
        return "ProfilController - Gère l'affichage et la mise à jour du profil client";
    }
}
