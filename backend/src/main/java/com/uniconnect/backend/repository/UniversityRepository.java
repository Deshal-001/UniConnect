package com.uniconnect.backend.repository;

import com.uniconnect.backend.model.University;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UniversityRepository extends JpaRepository<University,Long> {
    Optional<University> findByName(String name);
    List<University> findByNameStartingWithIgnoreCase(String prefix);
    List<University> findByLocationContainingIgnoreCase(String location);
}
