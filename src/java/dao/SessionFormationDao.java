package dao;

import entities.SessionFormation;
import java.time.LocalDate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import java.util.List;

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

    public List<SessionFormation> findByDate(LocalDate date) {
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

            return sessions;
        }
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

    public List<Object[]> countParticipantsBySession() {
        Session session = null;
        Transaction tx = null;
        List<Object[]> stats = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            stats = session.getNamedQuery("SessionFormation.countParticipantsBySession").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return stats;
    }

    public long countAll() {
    Session session = HibernateUtil.getSessionFactory().openSession();
    Transaction tx = null;
    long count = 0;
    try {
        tx = session.beginTransaction();
        count = ((Number) session.createSQLQuery("SELECT COUNT(*) FROM sessions_formation").uniqueResult()).longValue();
        System.out.println("Nombre de formations_internes (SessionFormationDao) : " + count);
        tx.commit();
    } catch (Exception e) {
        System.err.println("Erreur dans SessionFormationDao.countAll : " + e.getMessage());
        e.printStackTrace();
        if (tx != null) {
            tx.rollback();
        }
    } finally {
        session.close();
    }
    return count;
}

}
