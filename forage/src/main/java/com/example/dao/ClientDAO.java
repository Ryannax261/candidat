package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.Client;

@Repository
public interface ClientDAO extends JpaRepository<Client, Integer> {
}