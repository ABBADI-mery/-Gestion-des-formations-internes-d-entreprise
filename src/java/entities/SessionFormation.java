package entities;

import java.time.LocalDate;
import java.util.List;
import javax.persistence.*;

@Entity
@NamedQueries({
    @NamedQuery(
            name = "SessionFormation.findByTheme",
            query = "SELECT s FROM SessionFormation s WHERE s.formation.theme = :theme"
    ),
    @NamedQuery(
            name = "SessionFormation.findByDate",
            query = "SELECT s FROM SessionFormation s WHERE s.date = :date"
    ),
    @NamedQuery(
            name = "SessionFormation.findByFormateur",
            query = "SELECT s FROM SessionFormation s WHERE s.formateur = :nomFormateur"
    ),

    @NamedQuery(
            name = "SessionFormation.countParticipantsBySession",
            query = "SELECT s.formation.theme AS sessionName, COUNT(p) AS participantCount "
            + "FROM SessionFormation s LEFT JOIN s.participations p "
            + "GROUP BY s.formation.theme "
            + "ORDER BY participantCount DESC"
    )
})
@Table(name = "sessions_formation")

public class SessionFormation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private LocalDate date;
    private String formateur;

    // ManyToOne relation avec FormationInterne
    @ManyToOne
    @JoinColumn(name = "formation_interne_id")
    private FormationInterne formation;

    // Relation OneToMany avec Participation
    @OneToMany(mappedBy = "sessionFormation")
    private List<Participation> participations;

    public SessionFormation() {
    }

    public SessionFormation(FormationInterne formation, LocalDate date, String formateur) {
        this.formation = formation;
        this.date = date;
        this.formateur = formateur;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public FormationInterne getFormation() {
        return formation;
    }

    public void setFormation(FormationInterne formation) {
        this.formation = formation;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getFormateur() {
        return formateur;
    }

    public void setFormateur(String formateur) {
        this.formateur = formateur;
    }

    public List<Participation> getParticipations() {
        return participations;
    }

    public void setParticipations(List<Participation> participations) {
        this.participations = participations;
    }
}
