package com.example.RestAPI.Repository;

import com.example.RestAPI.entity.Pet;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PetsRepository extends JpaRepository<Pet, Integer> {
    Pet findByName(String name);
}
