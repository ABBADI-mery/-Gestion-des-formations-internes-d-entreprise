package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "client")
@NamedQueries({
    @NamedQuery(
        name = "Client.findByEmail",
        query = "SELECT u FROM User u WHERE u.email = :email"
    )
})
public class Client extends User {

    // Utilisation de camelCase pour le nom de la liste
    @OneToMany(mappedBy = "client")
    private List<Participation> participations;

    // Constructeur par défaut
    public Client() {
    }

    // Constructeur avec paramètres pour initialiser nom, email, motDePasse, et participation

    public Client(String nom, String email, String motDePasse, String secretQuestion, String secretAnswer) {
        super(nom, email, motDePasse, secretQuestion, secretAnswer);
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
