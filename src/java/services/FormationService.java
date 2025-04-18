/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.FormationInterneDao;
import entities.FormationInterne;
import java.util.List;

/**
 *
 * @author pc
 */
public class FormationService implements IService<FormationInterne>{

    private final FormationInterneDao dao;

    public FormationService() {
        this.dao = new FormationInterneDao();
    }

   

    @Override
    public boolean create(FormationInterne o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(FormationInterne o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(FormationInterne o) {
        return dao.update(o);
    }

    @Override
    public List<FormationInterne> findAll() {
        return dao.findAll();
    }

    @Override
    public FormationInterne findById(int id) {
        return dao.findById(id);
    }
}
