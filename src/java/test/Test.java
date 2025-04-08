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
        Admin admin = new Admin("Admin1", "admin1@example.com", "admin123");
        userDao.create(admin);

        // Créer des clients
        Client client1 = new Client("Client1", "client1@example.com", "client123");
        Client client2 = new Client("Client2", "client2@example.com", "client456");

        userDao.create(client1);
        userDao.create(client2);

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

        // Afficher les participations
        for (Participation p : participationDao.findAll()) {
            System.out.println(p);  // Affiche automatiquement le résultat via la méthode toString()
        }
    }
}
