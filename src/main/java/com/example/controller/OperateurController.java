package com.example.controller;

import com.example.service.OperateurService;
import com.example.model.Operateur;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/operateurs")
public class OperateurController {

    @Autowired
    private OperateurService operateurService;

    @GetMapping
    public String listOperateurs(Model model) {
        List<Operateur> operateurs = operateurService.getAllOperateurs();
        model.addAttribute("operateurs", operateurs);
        return "operateur/list";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("operateur", new Operateur());
        return "operateur/form";
    }

    @PostMapping("/save")
    public String saveOperateur(@ModelAttribute("operateur") Operateur operateur) {
        operateurService.saveOperateur(operateur);
        return "redirect:/operateurs";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        Operateur operateur = operateurService.getOperateurById(id);
        if (operateur == null) {
            return "redirect:/operateurs";
        }
        model.addAttribute("operateur", operateur);
        return "operateur/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteOperateur(@PathVariable("id") Integer id) {
        operateurService.deleteOperateurById(id);
        return "redirect:/operateurs";
    }
}
