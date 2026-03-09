package com.example.controller;

import com.example.service.MatiereService;
import com.example.model.Matiere;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/matieres")
public class MatiereController {

    @Autowired
    private MatiereService matiereService;

    @GetMapping
    public String listMatieres(Model model) {
        List<Matiere> matieres = matiereService.getAllMatieres();
        model.addAttribute("matieres", matieres);
        return "matiere/list";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("matiere", new Matiere());
        return "matiere/form";
    }

    @PostMapping("/save")
    public String saveMatiere(@ModelAttribute("matiere") Matiere matiere) {
        matiereService.saveMatiere(matiere);
        return "redirect:/matieres";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        Matiere matiere = matiereService.getMatiereById(id);
        if (matiere == null) {
            return "redirect:/matieres";
        }
        model.addAttribute("matiere", matiere);
        return "matiere/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteMatiere(@PathVariable("id") Integer id) {
        matiereService.deleteMatiereById(id);
        return "redirect:/matieres";
    }
}
