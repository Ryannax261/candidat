package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.dao.ClientDAO;
import com.example.model.Client;

@Service
public class ClientService {

    private final ClientDAO ClientDAO;

    public ClientService(ClientDAO ClientDAO) {
        this.ClientDAO = ClientDAO;
    }

    public List<Client> getAll() {
        return ClientDAO.findAll();
    }

    public Client save(Client client) {
        return ClientDAO.save(client);
    }

    public Client getById(int id) {
        return ClientDAO.findById(id).orElse(null);
    }

    public void delete(int id) {
        ClientDAO.deleteById(id);
    }
}
