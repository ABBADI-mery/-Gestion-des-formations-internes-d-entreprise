package dao;

import entities.SessionFormation;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import java.util.List;
import java.util.Date;

public class SessionFormationDao extends AbstractDao<SessionFormation> {

    public SessionFormationDao() {
        super(SessionFormation.class);
    }

    public List<SessionFormation> findByTheme(String theme) {
        Session session = null;
        Transaction tx = null;
        List<SessionFormation> sessions = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            sessions = session.getNamedQuery("SessionFormation.findByTheme").setParameter("theme", theme).list();

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
        return sessions;
    }

    public List<SessionFormation> findByDate(Date date) {
        Session session = null;
        Transaction tx = null;
        List<SessionFormation> sessions = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            sessions = session.getNamedQuery("SessionFormation.findByDate").setParameter("date", date).list();
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
        return sessions;
    }

    public List<SessionFormation> findByFormateur(String nomFormateur) {
        Session session = null;
        Transaction tx = null;
        List<SessionFormation> sessions = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            sessions = session.getNamedQuery("SessionFormation.findByFormateur").setParameter("nomFormateur", nomFormateur).list();
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
        return sessions;
    }

}
