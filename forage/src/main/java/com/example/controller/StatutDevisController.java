package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.model.StatutDevis;
import com.example.service.StatutDevisService;

@Controller
@RequestMapping("/admin/statut_devis")
public class StatutDevisController {

    private final StatutDevisService service;

    public StatutDevisController(StatutDevisService service) {
        this.service = service;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("statuts", service.getAll());
        return "admin/statut_devis/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("statut", new StatutDevis());
        return "admin/statut_devis/form";
    }

    @PostMapping
    public String store(@ModelAttribute StatutDevis statutDevis) {
        service.save(statutDevis);
        return "redirect:/admin/statut_devis";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("statut", service.getById(id));
        return "admin/statut_devis/form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/statut_devis";
    }
}
