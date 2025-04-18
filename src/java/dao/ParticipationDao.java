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

}
