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

import java.time.LocalDate;
import java.util.List;

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
        Admin admin = new Admin("MrZahid", "admin1@example.com", "admin123");
        userDao.create(admin);

        // Créer des clients
        Client client1 = new Client("meryam", "client1@example.com", "client123");
        Client client2 = new Client("fatima", "client2@example.com", "client456");
        Client client3 = new Client("hiba", "client3@example.com", "client789");

        userDao.create(client1);
        userDao.create(client2);
        userDao.create(client3);

        // Créer une formation
        FormationInterne formation = new FormationInterne("Spring Boot", "Développement Web", 3);
        formationDao.create(formation);

        // Créer une session pour cette formation
        SessionFormation session = new SessionFormation(formation, LocalDate.of(2025, 4, 20), "Mme El Yassir");
        sessionDao.create(session);

        // Inscrire les clients à la session
        Participation participation1 = new Participation(session, client1);
        Participation participation2 = new Participation(session, client2);

        participationDao.create(participation1);
        participationDao.create(participation2);

        //  Afficher toutes les participations
        System.out.println("\n Toutes les participations :");
        for (Participation p : participationDao.findAll()) {
            System.out.println(p);
        }

        //  Participations d’un client spécifique (par ID)
        System.out.println("\n Participations de la cliente meryam :");
        for (Participation p : participationDao.findAll()) {
            if (p.getClient().getId() == client1.getId()) {
                System.out.println(p);
            }
        }

        //  Sessions d'une formation spécifique (par ID)
        System.out.println("\n Sessions de la formation Spring Boot :");
        for (SessionFormation s : sessionDao.findAll()) {
            if (s.getFormation().getId() == formation.getId()) {
                System.out.println("Session ID: " + s.getId() + ", Date: " + s.getDate() + ", Formateur: " + s.getFormateur());
            }
        }

        //  Sessions après une date spécifique
        System.out.println("\n Sessions après le 15 avril 2025 :");
        for (SessionFormation s : sessionDao.findAll()) {
            if (s.getDate().isAfter(LocalDate.of(2025, 4, 15))) {
                System.out.println("Session ID: " + s.getId() + ", Date: " + s.getDate());
            }
        }

    }
}
