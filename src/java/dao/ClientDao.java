package dao;

import entities.Client;
import entities.SessionFormation;
import java.util.Collections;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class ClientDao extends AbstractDao<Client> {

    public ClientDao() {
        super(Client.class);
    }

    public Client findByEmail(String email) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Client client = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM Client c WHERE c.email = :email");
            query.setParameter("email", email);
            client = (Client) query.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return client;
    }

    public List<Client> findAllWithSessions() {
    Session session = HibernateUtil.getSessionFactory().openSession();
    Transaction tx = null;
    List<Client> clients = null;
    try {
        tx = session.beginTransaction();
        Query query = session.createQuery(
                "FROM Client c LEFT JOIN FETCH c.participations p LEFT JOIN FETCH p.sessionFormation sf LEFT JOIN FETCH sf.formation");
        System.out.println("Executing query: " + query.getQueryString());
        clients = query.list();
        System.out.println("Found " + (clients != null ? clients.size() : 0) + " clients");
        tx.commit();
    } catch (HibernateException e) {
        if (tx != null) {
            tx.rollback();
        }
        e.printStackTrace();
    } finally {
        session.close();
    }
    return clients != null ? clients : Collections.emptyList();
}
}