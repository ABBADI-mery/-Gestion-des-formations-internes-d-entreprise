/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.User;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class UserDao extends AbstractDao<User> {

    public UserDao() {
        super(User.class);
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
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return user;
    }

    public long countAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        long count = 0;
        try {
            tx = session.beginTransaction();
            count = ((Number) session.createSQLQuery("SELECT COUNT(*) FROM users").uniqueResult()).longValue();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count;
    }
}
