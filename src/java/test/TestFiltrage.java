/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.SessionFormationDao;
import entities.SessionFormation;
import java.util.Date;
import java.util.List;

/**
 *
 * @author pc
 */
public class TestFiltrage {
    
    public static void main(String[] args) {
        // Initialisation de l'objet SessionFormationDao
        SessionFormationDao sessionFormationDao = new SessionFormationDao();
        
        // Tester la méthode findByTheme
        String theme = "Développement Web";
        List<SessionFormation> sessionsByTheme = sessionFormationDao.findByTheme(theme);
        System.out.println("Sessions for theme " + theme + ":");
        for (SessionFormation session : sessionsByTheme) {
            System.out.println(session.getFormation().getTheme() + " - " + session.getDate());
        }
        
        // Tester la méthode findByDate
        //Date date = new Date(); // Date actuelle
        //List<SessionFormation> sessionsByDate = sessionFormationDao.findByDate(date);
        //System.out.println("\nSessions for date " + date + ":");
        //for (SessionFormation session : sessionsByDate) {
       //     System.out.println(session.getFormation().getTheme() + " - " + session.getDate());
       // }
        
        // Tester la méthode findByFormateur
        String formateur = "Mme Nadia";
        List<SessionFormation> sessionsByFormateur = sessionFormationDao.findByFormateur(formateur);
        System.out.println("\nSessions for formateur " + formateur + ":");
        for (SessionFormation session : sessionsByFormateur) {
            System.out.println(session.getFormation().getTheme() + " - " + session.getFormateur());
        }
    }
}
