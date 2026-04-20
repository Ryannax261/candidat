package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.model.Client;
import com.example.service.ClientService;

@Controller
@RequestMapping("/admin/clients")
public class ClientController {

    private final ClientService service;

    public ClientController(ClientService service) {
        this.service = service;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("clients", service.getAll());
        return "admin/clients/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("client", new Client());
        return "admin/clients/form";
    }

    @PostMapping
    public String store(@ModelAttribute Client client) {
        service.save(client);
        return "redirect:/admin/clients";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("client", service.getById(id));
        return "admin/clients/form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/clients";
    }
}