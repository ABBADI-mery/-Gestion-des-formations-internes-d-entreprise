package controllers;

import entities.Client;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.UserService;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {

    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération des paramètres
        String nom = request.getParameter("nom");
        String email = request.getParameter("email").trim().toLowerCase();
        String password = request.getParameter("motDePasse");
        String confirmPassword = request.getParameter("confirmPassword");
        String secretQuestion = request.getParameter("secretQuestion");
        String secretAnswer = request.getParameter("secretAnswer");

        // Validation des champs
        if (nom == null || nom.isEmpty() || email == null || email.isEmpty()
                || password == null || password.isEmpty() || secretQuestion == null
                || secretQuestion.isEmpty() || secretAnswer == null || secretAnswer.isEmpty()) {

            sendError(request, response, "Tous les champs sont obligatoires");
            return;
        }

        // Validation du mot de passe
        if (!password.equals(confirmPassword)) {
            sendError(request, response, "Les mots de passe ne correspondent pas");
            return;
        }

        if (password.length() < 8) {
            sendError(request, response, "Le mot de passe doit contenir au moins 8 caractères");
            return;
        }

        // Vérification de l'email existant
        if (userService.findByEmail(email) != null) {
            sendError(request, response, "Cet email est déjà utilisé");
            return;
        }

        try {
            // Hachage du mot de passe
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            System.out.println("Mot de passe haché pour l'utilisateur " + email + ": " + hashedPassword);

            // Hachage de la réponse secrète
            String hashedSecretAnswer = BCrypt.hashpw(secretAnswer.toLowerCase().trim(), BCrypt.gensalt());
            System.out.println("Réponse secrète hachée pour l'utilisateur " + email + ": " + hashedSecretAnswer);

            // Création du client
            Client client = new Client();
            client.setNom(nom);
            client.setEmail(email);
            client.setMotDePasse(hashedPassword);
            client.setSecretQuestion(secretQuestion);
            client.setSecretAnswer(hashedSecretAnswer);

            // Enregistrement en base
            if (userService.create(client)) {
                System.out.println("Utilisateur enregistré avec succès : Email=" + email);
                // Redirection avec message de succès
                response.sendRedirect("login.jsp?success=Compte créé avec succès. Vous pouvez maintenant vous connecter.");
            } else {
                System.err.println("Échec de l'enregistrement de l'utilisateur : Email=" + email);
                sendError(request, response, "Une erreur est survenue lors de la création du compte");
            }

        } catch (Exception e) {
            System.err.println("Erreur système lors de l'inscription : " + e.getMessage());
            sendError(request, response, "Erreur système: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("erreur", message);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
