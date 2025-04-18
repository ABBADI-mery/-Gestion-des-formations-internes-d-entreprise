package test;

import dao.FormationInterneDao;
import entities.FormationInterne;
import entities.SessionFormation;

import java.util.List;

public class TestSessionFormation {

    public static void main(String[] args) {

        FormationInterneDao formationInterneDao = new FormationInterneDao();

        int formationId = 1;
        FormationInterne formation = formationInterneDao.findById(formationId);

        if (formation != null) {

            List<SessionFormation> sessions = formationInterneDao.findSessionsByFormationId(formation);

            if (sessions != null && !sessions.isEmpty()) {
                System.out.println("Sessions pour la formation : " + formation.getTitre());
                for (SessionFormation session : sessions) {
                    System.out.println("Session ID: " + session.getId() + ", Date: " + session.getDate());
                }
            } else {
                System.out.println("Aucune session trouvée pour la formation : " + formation.getTitre());
            }
        } else {
            System.out.println("Formation avec ID " + formationId + " introuvable.");
        }
    }
}
