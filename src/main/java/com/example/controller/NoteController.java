package com.example.controller;

import com.example.model.Candidat;
import com.example.model.Matiere;
import com.example.model.Note;
import com.example.service.CandidatService;
import com.example.service.CorrecteurService;
import com.example.service.MatiereService;
import com.example.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private MatiereService matiereService;
    
    @Autowired
    private CorrecteurService correcteurService;

    @GetMapping
    public String listNotes(Model model) {
        List<Note> allNotes = noteService.getAllNotes();
        // Group notes by Candidat and Matiere for a cleaner list view
        Map<String, List<Note>> groupedNotes = new LinkedHashMap<>();
        for (Note n : allNotes) {
            String key = n.getCandidat().getMatricule() + " - " + n.getCandidat().getNom() + " | " + n.getMatiere().getNom();
            groupedNotes.computeIfAbsent(key, k -> new ArrayList<>()).add(n);
        }
        
        model.addAttribute("groupedNotes", groupedNotes);
        return "note/list";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("note", new Note());
        populateDropdowns(model);
        return "note/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        Note note = noteService.getNoteById(id);
        if (note != null) {
            model.addAttribute("note", note);
            populateDropdowns(model);
            return "note/form";
        }
        return "redirect:/notes";
    }

    @PostMapping("/save")
    public String saveMultipleNotes(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("candidatId") Integer candidatId,
            @RequestParam("matiereId") Integer matiereId,
            @RequestParam("correcteurIds") List<Integer> correcteurIds,
            @RequestParam("noteValues") List<Double> noteValues) {

        Candidat baseCandidat = candidatService.getCandidatById(candidatId);
        Matiere baseMatiere = matiereService.getMatiereById(matiereId);

        if (id != null) {
            // Edit single note mode
            Note existingNote = noteService.getNoteById(id);
            if (existingNote != null && !correcteurIds.isEmpty() && !noteValues.isEmpty()) {
                existingNote.setCandidat(baseCandidat);
                existingNote.setMatiere(baseMatiere);
                existingNote.setCorrecteur(correcteurService.getCorrecteurById(correcteurIds.get(0)));
                existingNote.setNote(noteValues.get(0));
                noteService.saveNote(existingNote);
            }
        } else {
            // Add multiple notes mode
            if (correcteurIds != null && noteValues != null) {
                for (int i = 0; i < correcteurIds.size(); i++) {
                    Note note = new Note();
                    note.setCandidat(baseCandidat);
                    note.setMatiere(baseMatiere);
                    note.setCorrecteur(correcteurService.getCorrecteurById(correcteurIds.get(i)));
                    note.setNote(noteValues.get(i));
                    noteService.saveNote(note);
                }
            }
        }
        return "redirect:/notes";
    }

    @GetMapping("/delete/{id}")
    public String deleteNote(@PathVariable("id") Integer id) {
        noteService.deleteNoteById(id);
        return "redirect:/notes";
    }
    
    private void populateDropdowns(Model model) {
        model.addAttribute("candidats", candidatService.getAllCandidats());
        model.addAttribute("matieres", matiereService.getAllMatieres());
        model.addAttribute("correcteurs", correcteurService.getAllCorrecteurs());
    }

    @GetMapping("/final")
    public String showFinalNoteForm(Model model) {
        // Here we just reuse populateDropdowns to pass matieres and candidats, ignoring correcteurs.
        populateDropdowns(model);
        return "note/Notefinal";
    }

    @PostMapping("/final/compute")
    public String computeFinalNote(
            @RequestParam("candidatId") Integer candidatId,
            @RequestParam("matiereId") Integer matiereId,
            Model model) {
        Candidat candidat = candidatService.getCandidatById(candidatId);
        Matiere matiere = matiereService.getMatiereById(matiereId);
        // For now, let's just create a dummy calculation placeholder
        Double dummyFinalNote = noteService.CalculNoteFinal(candidat, matiere);

        model.addAttribute("finalNote", dummyFinalNote);
        populateDropdowns(model);
        return "note/Notefinal";
    }
}
