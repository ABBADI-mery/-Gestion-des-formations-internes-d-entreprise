package test;

import dao.ClientDao;
import dao.ParticipationDao;
import entities.Client;
import entities.Participation;

public class TestParticipationByClient {

    public static void main(String[] args) {
        ParticipationDao participationDao = new ParticipationDao();
        ClientDao clientDao = new ClientDao();
        int clientId = 2;
        Client client = clientDao.findById(clientId);

        if (client == null) {
            System.out.println("Client avec ID " + clientId + " introuvable.");
            return;
        }

        System.out.println("Participations du client : " + client.getNom());

        for (Participation participation : participationDao.findByClientId(client)) {
            System.out.println("Session ID : " + participation.getSessionFormation().getId()
                    + " | Titre formation : " + participation.getSessionFormation().getFormation().getTitre()
                    + " | Client : " + participation.getClient().getNom());
        }
    }
}
