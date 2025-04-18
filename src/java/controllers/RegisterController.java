package controllers;

import entities.Client;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.UserService;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private UserService userService = new UserService();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("motDePasse");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation basique
        if (!password.equals(confirmPassword)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Vérifier si l'email existe déjà
        if (userService.findByEmail(email) != null) {
            request.setAttribute("erreur", "Cet email est déjà utilisé");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Créer le client
        Client client = new Client();
        client.setNom(nom);
        client.setEmail(email);
        client.setMotDePasse(password); // Devrait être hashé en production
        
        if (userService.create(client)) {
            response.sendRedirect("login.jsp?success=Compte créé avec succès");
        } else {
            request.setAttribute("erreur", "Erreur lors de la création du compte");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}