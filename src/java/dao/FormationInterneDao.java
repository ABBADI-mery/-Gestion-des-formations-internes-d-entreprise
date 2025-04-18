/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.FormationInterne;
import entities.SessionFormation;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import java.util.List;

/**
 *
 * @author pc
 */
public class FormationInterneDao extends AbstractDao<FormationInterne> {

    public FormationInterneDao() {
        super(FormationInterne.class);
    }
    // Méthode pour récupérer toutes les sessions d'une formation par son ID

    public List<SessionFormation> findSessionsByFormationId(FormationInterne formation) {
        Session session = null;
        Transaction tx = null;
        List<SessionFormation> sessions = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            sessions = session
                    .getNamedQuery("FormationInterne.findSessionsByFormationId")
                    .setParameter("formationId", formation.getId())
                    .list();

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

        return sessions;
    }

}
