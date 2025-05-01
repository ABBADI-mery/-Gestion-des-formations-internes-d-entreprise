package controllers;

import entities.User;
import services.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import com.google.gson.Gson;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;
        String getQuestion = request.getParameter("getQuestion");
        String secretAnswer = request.getParameter("secretAnswer");

        // Étape 1 : Récupérer la question secrète
        if (getQuestion != null && email != null) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();

            try {
                User user = us.findByEmail(email);
                if (user == null) {
                    out.print(gson.toJson(new Response("Email non trouvé.")));
                    return;
                }
                if (user.getId() == 0) {
                    out.print(gson.toJson(new Response("Erreur : ID de l'utilisateur non valide.")));
                    return;
                }
                if (user.getSecretQuestion() == null || user.getSecretQuestion().isEmpty()) {
                    out.print(gson.toJson(new Response("Aucune question secrète configurée.")));
                    return;
                }

                out.print(gson.toJson(new Response(null, user.getSecretQuestion())));
            } catch (Exception e) {
                out.print(gson.toJson(new Response("Erreur système : " + e.getMessage())));
            } finally {
                out.close();
            }
            return;
        }

        // Étape 2 : Vérifier la réponse et envoyer le mot de passe
        if (email == null || email.isEmpty()) {
            sendError(request, response, "L'email est requis.");
            return;
        }
        if (secretAnswer == null || secretAnswer.isEmpty()) {
            sendError(request, response, "La réponse à la question secrète est requise.");
            return;
        }

        try {
            User user = us.findByEmail(email);
            if (user == null) {
                sendError(request, response, "Email non trouvé.");
                return;
            }
            if (user.getId() == 0) {
                sendError(request, response, "Erreur : ID de l'utilisateur non valide.");
                return;
            }

            // Normaliser la réponse (minuscules et suppression des espaces)
            String normalizedAnswer = secretAnswer.toLowerCase().trim();

            // Vérifier la réponse à la question secrète
            if (!us.verifySecretAnswer(user, normalizedAnswer)) {
                sendError(request, response, "Réponse à la question secrète incorrecte.");
                return;
            }

            System.out.println("Utilisateur trouvé : ID=" + user.getId() + ", Email=" + user.getEmail());

            // Générer un nouveau mot de passe aléatoire
            String newPassword = generateRandomPassword(12);
            System.out.println("Nouveau mot de passe généré : " + newPassword);

            // Mettre à jour le mot de passe de l'utilisateur
            us.updatePassword(user, newPassword);

            // Envoyer le nouveau mot de passe par email
            sendPasswordEmail(user.getEmail(), newPassword);

            request.setAttribute("success", "Un nouveau mot de passe a été envoyé à votre email.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            sendError(request, response, "Erreur système : " + e.getMessage());
        }
    }

    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < length; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        return password.toString();
    }

    private void sendPasswordEmail(String email, String newPassword) throws MessagingException {
        String host = "smtp.gmail.com";
        String port = "587";
        String username = "mrymbady525@gmail.com";
        String password = "vsxbxopzdqhciskz";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        String loginLink = "http://localhost:8080/MeryAcademi/login.jsp";
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
        message.setSubject("Votre nouveau mot de passe");
        message.setText("Votre nouveau mot de passe est : " + newPassword + 
                        "\n\nConnectez-vous ici : " + loginLink + 
                        "\n\nVeuillez modifier ce mot de passe dès que possible.");
        Transport.send(message);
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("erreur", message);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Classe interne pour la réponse JSON
    private static class Response {
        String error;
        String secretQuestion;

        Response(String error) {
            this.error = error;
        }

        Response(String error, String secretQuestion) {
            this.error = error;
            this.secretQuestion = secretQuestion;
        }
    }
}