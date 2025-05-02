/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author pc
 */
public class ClientDao extends AbstractDao<Client> {

    public ClientDao() {
        super(Client.class);
    }

    public Client findByEmail(String email) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<Client> findAllWithSessions() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        List<Client> clients = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery(
                    "FROM Client c LEFT JOIN FETCH c.participations p LEFT JOIN FETCH p.sessionFormation");
            clients = query.list(); 
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return clients;
    }

}
