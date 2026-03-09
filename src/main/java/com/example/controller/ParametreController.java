package com.example.controller;

import com.example.service.ParametreService;
import com.example.service.MatiereService;
import com.example.service.ResolutionService;
import com.example.service.OperateurService;
import com.example.model.Parametre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/parametres")
public class ParametreController {

    @Autowired
    private ParametreService parametreService;

    @Autowired
    private MatiereService matiereService;
    
    @Autowired
    private ResolutionService resolutionService;
    
    @Autowired
    private OperateurService operateurService;

    @GetMapping
    public String listParametres(Model model) {
        List<Parametre> parametres = parametreService.getAllParametres();
        model.addAttribute("parametres", parametres);
        return "parametre/list";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("parametre", new Parametre());
        model.addAttribute("matieres", matiereService.getAllMatieres());
        model.addAttribute("resolutions", resolutionService.getAllResolutions());
        model.addAttribute("operateurs", operateurService.getAllOperateurs());
        return "parametre/form";
    }

    @PostMapping("/save")
    public String saveParametre(@ModelAttribute("parametre") Parametre parametre) {
        parametreService.saveParametre(parametre);
        return "redirect:/parametres";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        Parametre parametre = parametreService.getParametreById(id);
        if (parametre == null) {
            return "redirect:/parametres";
        }
        model.addAttribute("parametre", parametre);
        model.addAttribute("matieres", matiereService.getAllMatieres());
        model.addAttribute("resolutions", resolutionService.getAllResolutions());
        model.addAttribute("operateurs", operateurService.getAllOperateurs());
        return "parametre/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteParametre(@PathVariable("id") Integer id) {
        parametreService.deleteParametreById(id);
        return "redirect:/parametres";
    }
}
