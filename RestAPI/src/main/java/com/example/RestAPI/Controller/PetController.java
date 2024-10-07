package com.example.RestAPI.Controller;

import com.example.RestAPI.Service.PetService;
import com.example.RestAPI.entity.Pet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PetController {

    @Autowired
    private PetService service;

    @PostMapping("/addPet")
    public Pet addPet(Pet pet) {
        return service.savePet(pet);
    }

    @PostMapping("/addPets")
    public List<Pet> addPets(@RequestBody List<Pet> pets) {
        return service.savePets(pets);
    }

    @GetMapping("/pets")
    public List<Pet> finaAll() {
        return service.getPets();
    }

    @GetMapping("petById/{id}")
    public Pet findPetById(@PathVariable int id) {
        return service.getPetById(id);
    }

    @GetMapping("petByName/{name}")
    public Pet findPetByName(@PathVariable String name) {
        return service.getPetByName(name);
    }

    @PutMapping("/updatePet")
    // public Pet updatePet(@RequestBody Pet pet) {return service.updatePet(pet);}  // works in postman but not android studio
    public Pet updatePet(Pet pet) {
        return service.updatePet(pet);
    }  // works in android studio but not postman

    @DeleteMapping("delete/{id}")
    public String deletePet(@PathVariable int id) {
        return service.deletePet(id);
    }
}