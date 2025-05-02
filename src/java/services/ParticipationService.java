/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.ParticipationDao;
import entities.Client;
import entities.Participation;
import entities.SessionFormation;
import java.util.List;

/**
 *
 * @author pc
 */
public class ParticipationService implements IService<Participation> {

    private final ParticipationDao dao;

    public ParticipationService() {
        this.dao = new ParticipationDao();
    }

    @Override
    public boolean create(Participation o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Participation o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Participation o) {
        return dao.update(o);
    }

    @Override
    public List<Participation> findAll() {
        return dao.findAll();
    }

    @Override
    public Participation findById(int id) {

        return dao.findById(id);
    }

    public List<Participation> findByClient(Client client) {
        return dao.findByClientId(client);
    }

}
