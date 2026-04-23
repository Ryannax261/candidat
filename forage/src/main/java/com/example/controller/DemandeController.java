package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.model.Demande;
import com.example.service.ClientService;
import com.example.service.DemandeService;
import com.example.service.StatutService;

@Controller
@RequestMapping("/admin/demande")
public class DemandeController {

    private final DemandeService service;
    private final ClientService clientService;
    private final StatutService statutService;

    public DemandeController(DemandeService service, ClientService clientService,
                              StatutService statutService) {
        this.service = service;
        this.clientService = clientService;
        this.statutService = statutService;
    }

    @GetMapping
    public String index(Model model, 
                        @RequestParam(name = "statutId", required = false) Integer statutId,
                        @RequestParam(name = "clientId", required = false) Integer clientId) {
        if (statutId != null) {
            model.addAttribute("demandes", service.getByStatut(statutId));
        } else if (clientId != null) {
            model.addAttribute("demandes", service.getByClient(clientId));
            model.addAttribute("filteredClient", clientService.getById(clientId));
        } else {
            model.addAttribute("demandes", service.getAll());
        }
        return "admin/demande/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("demande", new Demande());
        model.addAttribute("clients", clientService.getAll());

        return "admin/demande/form";
    }

    @PostMapping
    public String store(@ModelAttribute Demande demande) {
        service.creer(demande);
        return "redirect:/admin/demande";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("demande", service.getById(id));
        model.addAttribute("clients", clientService.getAll());
        model.addAttribute("statuts", statutService.getAll());
        return "admin/demande/form";
    }

    @PostMapping("/update/{id}")
    public String update(@PathVariable int id,
                         @ModelAttribute Demande demande,
                         @RequestParam("statutId") int statutId) {
        demande.setId(id);
        service.update(demande, statutId);
        return "redirect:/admin/demande";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/demande";
    }

    @GetMapping("/{id}/statut")
    public String status(@PathVariable int id, Model model) {
        model.addAttribute("demande", service.getById(id));
        model.addAttribute("statuts", statutService.getAll());
        return "admin/demande/statut";
    }

    @PostMapping("/{id}/statut")
    public String changeStatus(@PathVariable int id,
                               @RequestParam("statutId") int statutId,
                               @RequestParam("observation") String observation) {
        Demande demande = service.getById(id);
        service.update(demande, statutId, observation);
        return "redirect:/admin/demande/" + id + "/statut";
    }
}