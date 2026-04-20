package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.model.Devis;
import com.example.model.DetailDevis;

import com.example.service.DevisService;
import com.example.service.DemandeService;
import com.example.service.TypeDevisService;
import com.example.service.StatutDevisService;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import org.springframework.http.ResponseEntity;

@Controller
@RequestMapping("/admin/devis")
public class DevisController {

    private final DevisService service;
    private final DemandeService demandeService;
    private final TypeDevisService typeDevisService;
    private final StatutDevisService statutDevisService;

    public DevisController(DevisService service, DemandeService demandeService,
                           TypeDevisService typeDevisService, StatutDevisService statutDevisService) {
        this.service = service;
        this.demandeService = demandeService;
        this.typeDevisService = typeDevisService;
        this.statutDevisService = statutDevisService;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("devisStatuts", service.getAllStatusHistory());
        model.addAttribute("totalCA", service.getTotalTurnover());
        return "admin/devis/index";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("devis", new Devis());
        model.addAttribute("types", typeDevisService.getAll());
        return "admin/devis/form";
    }

    @GetMapping("/show/{id}")
    public String show(@PathVariable int id, Model model) {
        model.addAttribute("devis", service.getById(id));
        model.addAttribute("statuts", statutDevisService.getAll());
        return "admin/devis/show";
    }


    @GetMapping("/api/demande/{id}")
    @ResponseBody
    public ResponseEntity<?> getDemandeInfo(@PathVariable int id) {

        java.util.Map<String, Object> info = demandeService.getInfoDemande(id);
        if (info == null) {
            return ResponseEntity.notFound().build();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("clientNom",   info.getOrDefault("nom_client",   info.get("NOM_CLIENT")));
        response.put("dateDemande", String.valueOf(info.getOrDefault("date_demande", info.get("DATE_DEMANDE"))));
        response.put("district",    info.getOrDefault("district",     info.get("DISTRICT")));

        return ResponseEntity.ok(response);
    }

    @PostMapping("/save")
    public String save(@RequestParam("demandeId") int demandeId,
                       @RequestParam("typeDevisId") int typeDevisId,
                       @RequestParam("libelle[]") String[] libelles,
                       @RequestParam("pu[]") double[] pus,
                       @RequestParam("qtt[]") int[] qtts) {

        Devis devis = new Devis();
        devis.setDemande(demandeService.getById(demandeId));
        devis.setTypeDevis(typeDevisService.getById(typeDevisId));

        List<DetailDevis> details = new ArrayList<>();
        for (int i = 0; i < libelles.length; i++) {
            DetailDevis detail = new DetailDevis();
            detail.setLibelle(libelles[i]);
            detail.setPu(pus[i]);
            detail.setQuantite(qtts[i]);
            details.add(detail);
        }

        service.saveDevis(devis, details);
        return "redirect:/admin/devis";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("devis", service.getById(id));
        model.addAttribute("types", typeDevisService.getAll());
        return "admin/devis/form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/devis";
    }

    @PostMapping("/statut/{id}")
    public String updateStatut(@PathVariable int id,
                               @RequestParam("statutDevisId") int statutDevisId) {
        service.updateStatut(id, statutDevisId);
        return "redirect:/admin/devis/show/" + id;
    }
}
