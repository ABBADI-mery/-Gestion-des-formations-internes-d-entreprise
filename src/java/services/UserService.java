package services;

import dao.UserDao;
import entities.User;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import org.mindrot.jbcrypt.BCrypt;

public class UserService implements IService<User> {

    private final UserDao ud;

    public UserService() {
        this.ud = new UserDao();
    }

    @Override
    public boolean create(User o) {

        boolean created = ud.create(o);
        if (created) {
            System.out.println("Utilisateur créé avec succès : ID=" + o.getId() + ", Email=" + o.getEmail());
        } else {
            System.err.println("Échec de la création de l'utilisateur : Email=" + o.getEmail());
        }
        return created;
    }

    @Override
    public boolean update(User o) {
        return ud.update(o);
    }

    @Override
    public boolean delete(User o) {
        return ud.delete(o);
    }

    @Override
    public List<User> findAll() {
        return ud.findAll();
    }

    @Override
    public User findById(int id) {
        return ud.findById(id);
    }

    public User findByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        User user = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            user = (User) session
                    .getNamedQuery("User.findByEmail")
                    .setParameter("email", email)
                    .uniqueResult();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            System.err.println("Erreur lors de la recherche par email : " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return user;
    }

    public boolean verifySecretAnswer(User user, String providedAnswer) {
        if (user == null || user.getSecretAnswer() == null) {
            return false;
        }
        return BCrypt.checkpw(providedAnswer, user.getSecretAnswer());
    }

    public void updatePassword(User user, String newPassword) {
        Session session = null;
        Transaction tx = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            User managedUser = (User) session.get(User.class, user.getId());
            if (managedUser == null) {
                throw new RuntimeException("Utilisateur non trouvé dans la base de données : ID=" + user.getId());
            }

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            managedUser.setMotDePasse(hashedPassword);
            session.merge(managedUser);

            tx.commit();
            System.out.println("Mot de passe mis à jour avec succès pour l'utilisateur ID=" + user.getId() + ", Email=" + user.getEmail());
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            System.err.println("Erreur lors de la mise à jour du mot de passe : " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Échec de la mise à jour du mot de passe : " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
