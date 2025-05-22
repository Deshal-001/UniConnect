package com.uniconnect.backend.controller;

import com.uniconnect.backend.dto.UniDto;
import com.uniconnect.backend.model.University;
import com.uniconnect.backend.service.UniversityService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/api/university")
public class UniversityController {
    private final UniversityService universityService;

    public UniversityController(UniversityService universityService) {
        this.universityService = universityService;
    }

        // GET all universities
        @GetMapping
        public ResponseEntity<List<UniDto>> getAllUniversities() {
            return ResponseEntity.ok(universityService.getAllUniversities());
        }

        // Search universities by name prefix
        @GetMapping("/search")
        public ResponseEntity<List<UniDto>> searchByPrefix(@RequestParam("prefix") String prefix) {
            return ResponseEntity.ok(universityService.searchUniversity(prefix));
        }

        // Find university by exact name
        @GetMapping("/by-name")
        public ResponseEntity<UniDto> findByName(@RequestParam("name") String name) {
            return ResponseEntity.ok(universityService.findUniByName(name));

        }

        // Find universities by location (partial match, case-insensitive)
        @GetMapping("/by-location")
        public ResponseEntity<List<UniDto>> findByLocation(@RequestParam("location") String location) {
            return ResponseEntity.ok(universityService.findUniByLocation(location));
        }
    }




