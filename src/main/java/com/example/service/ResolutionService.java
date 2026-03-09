package com.example.service;

import com.example.dao.ResolutionDAO;
import com.example.model.Resolution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResolutionService {

    @Autowired
    private ResolutionDAO resolutionDAO;

    public List<Resolution> getAllResolutions() {
        return resolutionDAO.findAll();
    }

    public Resolution getResolutionById(Integer id) {
        return resolutionDAO.findById(id).orElse(null);
    }

    public void saveResolution(Resolution resolution) {
        resolutionDAO.save(resolution);
    }

    public void deleteResolutionById(Integer id) {
        resolutionDAO.deleteById(id);
    }
}
