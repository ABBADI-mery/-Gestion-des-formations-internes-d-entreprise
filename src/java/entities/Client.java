package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

@Entity
public class Client extends User {

    // Utilisation de camelCase pour le nom de la liste
    @OneToMany(mappedBy = "client")
    private List<Participation> participations;

    // Constructeur par défaut
    public Client() {
    }

    // Constructeur avec paramètres pour initialiser nom, email, motDePasse, et participation
    public Client(String nom, String email, String motDePasse) {
        super(nom, email, motDePasse);
    }

    // Getter pour les participations
    public List<Participation> getParticipations() {
        return participations;
    }

    // Setter pour les participations
    public void setParticipations(List<Participation> participations) {
        this.participations = participations;
    }
}
