package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.model.TypeDevis;
import com.example.service.TypeDevisService;

@Controller
@RequestMapping("/admin/type_devis")
public class TypeDevisController {

    private final TypeDevisService service;

    public TypeDevisController(TypeDevisService service) {
        this.service = service;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("types", service.getAll());
        return "admin/type_devis/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("type", new TypeDevis());
        return "admin/type_devis/form";
    }

    @PostMapping
    public String store(@ModelAttribute TypeDevis typeDevis) {
        service.save(typeDevis);
        return "redirect:/admin/type_devis";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("type", service.getById(id));
        return "admin/type_devis/form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/type_devis";
    }
}
