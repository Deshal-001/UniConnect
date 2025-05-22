package com.uniconnect.backend.service;

import com.uniconnect.backend.dto.UniDto;
import com.uniconnect.backend.exception.ApiException;
import com.uniconnect.backend.exception.ErrorCodes;
import com.uniconnect.backend.model.University;
import com.uniconnect.backend.repository.UniversityRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UniversityService {
    final UniversityRepository universityRepository;

    public UniversityService(UniversityRepository universityRepository) {
        this.universityRepository = universityRepository;
    }

    @Transactional
    public List<UniDto> searchUniversity(String prefix){
        return universityRepository.findByNameStartingWithIgnoreCase(prefix).stream().map(this:: mapToUniDto).toList();
    }

    @Transactional
    public UniDto findUniByName(String name){
        University uni = universityRepository.findByName(name).orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));
        return mapToUniDto(uni);
    }

    @Transactional
    public List<UniDto> findUniByLocation(String location){
        return universityRepository.findByLocationContainingIgnoreCase(location).stream().map(
this:: mapToUniDto
        ).toList();
    }

    @Transactional
    public List<UniDto> getAllUniversities(){
        return universityRepository.findAll().stream().map(this::mapToUniDto).toList();
    }

    //createMaptoDto
    private UniDto mapToUniDto(University university){
        UniDto uniDto = new UniDto();
        uniDto.setId(university.getId());
        uniDto.setName(university.getName());
        uniDto.setImgUrl(university.getImgUrl());
        uniDto.setLocation(university.getLocation());
        return uniDto;
    }






}
