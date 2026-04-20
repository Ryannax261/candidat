package com.example.controller;

import com.example.model.Statut;
import com.example.service.StatutService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/statut")
public class StatutController {

    private final StatutService service;

    public StatutController(StatutService service) {
        this.service = service;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("statuts", service.getAll());
        return "admin/statut/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("statut", new Statut());
        return "admin/statut/form";
    }

    @PostMapping
    public String store(@ModelAttribute Statut statut) {
        service.save(statut);
        return "redirect:/admin/statut";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("statut", service.getById(id));
        return "admin/statut/form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/statut";
    }
}
