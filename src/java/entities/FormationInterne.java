package entities;

import java.util.List;
import javax.persistence.*;

@Entity
@Table(name = "formations_internes")
public class FormationInterne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String titre;
    private String theme;
    private int duree;

    // Relation OneToMany avec SessionFormation, mappedBy doit correspondre au nom de la propriété dans SessionFormation
    @OneToMany(mappedBy = "formation", fetch = FetchType.EAGER)
    private List<SessionFormation> sessions;

    public FormationInterne() {
    }

    public FormationInterne(String titre, String theme, int duree) {
        this.titre = titre;
        this.theme = theme;
        this.duree = duree;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public List<SessionFormation> getSessions() {
        return sessions;
    }

    public void setSessions(List<SessionFormation> sessions) {
        this.sessions = sessions;
    }
}
