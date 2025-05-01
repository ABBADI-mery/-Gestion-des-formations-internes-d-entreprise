package test;

import dao.UserDao;
import dao.FormationInterneDao;
import dao.SessionFormationDao;
import dao.ParticipationDao;
import entities.Admin;
import entities.Client;
import entities.FormationInterne;
import entities.SessionFormation;
import entities.Participation;
import util.HibernateUtil;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;

public class Test {

    public static void main(String[] args) {
        // Initialiser la session Hibernate
        HibernateUtil.getSessionFactory();

        // Initialiser les DAO
        UserDao userDao = new UserDao();
        FormationInterneDao formationDao = new FormationInterneDao();
        SessionFormationDao sessionDao = new SessionFormationDao();
        ParticipationDao participationDao = new ParticipationDao();

        
            // Créer un administrateur
            String adminSecretAnswer = BCrypt.hashpw("Rex", BCrypt.gensalt());
            Admin admin = new Admin("MrZahid", "admin1@example.com", BCrypt.hashpw("admin123", BCrypt.gensalt()),
                    "Quel est le nom de votre premier animal de compagnie ?", adminSecretAnswer);
            if (userDao.findByEmail("admin1@example.com") == null) {
                userDao.create(admin);
                System.out.println("Admin créé : " + admin.getEmail());
            } else {
                System.out.println("Admin déjà existant : " + admin.getEmail());
            }

            // Créer des clients
            String client1SecretAnswer = BCrypt.hashpw("Luna", BCrypt.gensalt());
            String client2SecretAnswer = BCrypt.hashpw("Milo", BCrypt.gensalt());
            String client3SecretAnswer = BCrypt.hashpw("Bella", BCrypt.gensalt());

            Client client1 = new Client("meryam", "client1@example.com", BCrypt.hashpw("client123", BCrypt.gensalt()),
                    "Quel est le nom de votre premier animal de compagnie ?", client1SecretAnswer);
            Client client2 = new Client("fatima", "client2@example.com", BCrypt.hashpw("client456", BCrypt.gensalt()),
                    "Quel est le nom de votre ville natale ?", client2SecretAnswer);
            Client client3 = new Client("hiba", "client3@example.com", BCrypt.hashpw("client789", BCrypt.gensalt()),
                    "Quel est le nom de votre premier professeur ?", client3SecretAnswer);

            if (userDao.findByEmail("client1@example.com") == null) {
                userDao.create(client1);
                System.out.println("Client créé : " + client1.getEmail());
            } else {
                System.out.println("Client déjà existant : " + client1.getEmail());
            }

            if (userDao.findByEmail("client2@example.com") == null) {
                userDao.create(client2);
                System.out.println("Client créé : " + client2.getEmail());
            } else {
                System.out.println("Client déjà existant : " + client2.getEmail());
            }

            if (userDao.findByEmail("client3@example.com") == null) {
                userDao.create(client3);
                System.out.println("Client créé : " + client3.getEmail());
            } else {
                System.out.println("Client déjà existant : " + client3.getEmail());
            }

            // Créer une formation
            FormationInterne formation = new FormationInterne("Spring Boot", "Développement Web", 3);
            

            // Créer des sessions pour cette formation
            SessionFormation session1 = new SessionFormation(formation, LocalDate.of(2025, 4, 20), "Mme El Yassir");
            SessionFormation session2 = new SessionFormation(formation, LocalDate.of(2025, 5, 5), "Mr Amine");
            SessionFormation session3 = new SessionFormation(formation, LocalDate.of(2025, 6, 10), "Mme Nadia");

            
}}