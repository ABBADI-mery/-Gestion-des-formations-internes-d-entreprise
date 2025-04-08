package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ParticipationId implements Serializable {

    @Column(name = "session_formation_id")
    private int sessionFormationId;

    @Column(name = "client_id")
    private int clientId;

    public ParticipationId() {
    }

    public ParticipationId(int sessionFormationId, int clientId) {
        this.sessionFormationId = sessionFormationId;
        this.clientId = clientId;
    }

    public int getSessionFormationId() {
        return sessionFormationId;
    }

    public void setSessionFormationId(int sessionFormationId) {
        this.sessionFormationId = sessionFormationId;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ParticipationId that = (ParticipationId) o;

        if (sessionFormationId != that.sessionFormationId) return false;
        return clientId == that.clientId;
    }

    @Override
    public int hashCode() {
        int result = sessionFormationId;
        result = 31 * result + clientId;
        return result;
    }
}
