/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Client;
import entities.Participation;
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
public class ParticipationDao extends AbstractDao<Participation> {

    public ParticipationDao() {
        super(Participation.class);
    }

    public List<Participation> findByClientId(Client client) {
        Session session = null;
        Transaction tx = null;
        List<Participation> participations = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            participations = session.getNamedQuery("Participation.findByClient")
                    .setParameter("clientId", client.getId())
                    .list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {
            if (session != null) {
                session.close();
            }
        }
        return participations;
    }
    
public List<Object[]> countClientsByFormation() {
    Session session = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        
        // Requête pour compter les clients distincts par formation
        String hql = "SELECT f.titre, COUNT(DISTINCT p.client) " +
                     "FROM FormationInterne f " +
                     "JOIN f.sessions s " +
                     "JOIN s.participations p " +
                     "GROUP BY f.titre " +
                     "ORDER BY COUNT(DISTINCT p.client) DESC";
        
        return session.createQuery(hql).list();
    } finally {
        if (session != null) session.close();
    }
}

}
