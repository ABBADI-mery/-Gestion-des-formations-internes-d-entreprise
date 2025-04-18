package entities;

import javax.persistence.*;

@Entity
@NamedQueries({
    @NamedQuery(
            name = "Participation.findByClient",
            query = "SELECT p FROM Participation p WHERE p.client.id = :clientId"
    )
})
@Table(name = "participations")
public class Participation {

    @EmbeddedId
    private ParticipationId id;

    // Utilisation de "sessionFormation" comme nom pour la relation dans Participation
    @ManyToOne
    @JoinColumn(name = "session_formation_id", referencedColumnName = "id", insertable = false, updatable = false)
    private SessionFormation sessionFormation;

    @ManyToOne
    @JoinColumn(name = "client_id", referencedColumnName = "id", insertable = false, updatable = false)
    private Client client;

    public Participation() {
    }

    public Participation(SessionFormation sessionFormation, Client client) {
        this.sessionFormation = sessionFormation;
        this.client = client;
        this.id = new ParticipationId(sessionFormation.getId(), client.getId());
    }

    public ParticipationId getId() {
        return id;
    }

    public void setId(ParticipationId id) {
        this.id = id;
    }

    public SessionFormation getSessionFormation() {
        return sessionFormation;
    }

    public void setSessionFormation(SessionFormation sessionFormation) {
        this.sessionFormation = sessionFormation;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    @Override
    public String toString() {
        return "Participation{" + "id=" + id + ", sessionFormation=" + sessionFormation + ", client=" + client + '}';
    }

}
