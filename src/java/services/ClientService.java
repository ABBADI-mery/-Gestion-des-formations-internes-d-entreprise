package services;

import dao.ClientDao;
import entities.Client;
import java.util.List;

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

    public List<Client> findAllWithSessions() {
        return cd.findAllWithSessions();
    }

    @Override
    public Client findById(int id) {
        return cd.findById(id);
    }

    public Client findByEmail(String email) {
        return cd.findByEmail(email);
    }
}