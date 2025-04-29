package services;

import dao.SessionFormationDao;
import entities.SessionFormation;
import java.time.LocalDate;

import java.util.List;


public class SessionService implements IService<SessionFormation> {

    private final SessionFormationDao dao;

    public SessionService() {
        this.dao = new SessionFormationDao();
    }

    @Override
    public boolean create(SessionFormation o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(SessionFormation o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(SessionFormation o) {
        return dao.update(o);
    }

    @Override
    public List<SessionFormation> findAll() {
        return dao.findAll();
    }

    @Override
    public SessionFormation findById(int id) {
        return dao.findById(id);
    }

    // Méthodes spécifiques aux sessions
    public List<SessionFormation> findByTheme(String theme) {
        return dao.findByTheme(theme);
    }

    public List<SessionFormation> findByDate(LocalDate date) {
        return dao.findByDate(date);
    }

    public List<SessionFormation> findByFormateur(String nomFormateur) {
        return dao.findByFormateur(nomFormateur);
    }
}