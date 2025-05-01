/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;


import dao.ClientDao;
import entities.Client;
import entities.SessionFormation;
import java.util.List;

/**
 *
 * @author pc
 */
public class ClientService implements IService<Client> {

    private final ClientDao cd;

    public ClientService() {
        this.cd = new ClientDao();
    }

    @Override
    public boolean create(Client o) {
        return cd.create(o);
    }

    @Override
    public boolean update(Client o) {
        return cd.update(o);
    }

    @Override
    public boolean delete(Client o) {
        return cd.delete(o);
    }

    @Override
    public List<Client> findAll() {
        return cd.findAll();
    }

    @Override
    public Client findById(int id) {
        return cd.findById(id);
    }

    public Client findByEmail(String email) {
        return cd.findByEmail(email);
    }
    

}
