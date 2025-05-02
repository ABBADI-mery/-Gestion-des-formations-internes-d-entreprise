package entities;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NamedQueries({
    @NamedQuery(
            name = "User.findByEmail",
            query = "SELECT u FROM User u WHERE u.email = :email"
    )
})
@Table(name = "users")
@Inheritance(strategy = InheritanceType.JOINED)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nom;
    private String email;
    private String motDePasse;

    @Column(name = "secret_question")
    private String secretQuestion;

    @Column(name = "secret_answer")
    private String secretAnswer;

    public User() {
    }

    public User(String nom, String email, String motDePasse, String secretQuestion, String secretAnswer) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.secretQuestion = secretQuestion;
        this.secretAnswer = secretAnswer;
    }

    // Getters et Setters pour les champs existants
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    // Getters et Setters pour les nouveaux champs
    public String getSecretQuestion() {
        return secretQuestion;
    }

    public void setSecretQuestion(String secretQuestion) {
        this.secretQuestion = secretQuestion;
    }

    public String getSecretAnswer() {
        return secretAnswer;
    }

    public void setSecretAnswer(String secretAnswer) {
        this.secretAnswer = secretAnswer;
    }
}
