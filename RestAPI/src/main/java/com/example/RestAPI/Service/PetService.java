package com.example.RestAPI.Service;

import com.example.RestAPI.Repository.PetsRepository;
import com.example.RestAPI.entity.Pet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PetService {

    @Autowired
    private PetsRepository repository;

    public Pet savePet(Pet pet) {
        System.out.println("The pet "+ pet.getName() + " was added to the database");
        return repository.save(pet);

    }

    public List<Pet> savePets(List<Pet> pets) {
        return repository.saveAll(pets);

    }

    public List<Pet> getPets() {
        System.out.println("The list of  pets is access from the database");
        return repository.findAll();
    }

    public Pet getPetById(int id) {

        return repository.findById(id).orElse(null);
    }

    public Pet getPetByName(String name) {
        return repository.findByName(name);
    }




    public String deletePet(int id)
    {
        System.out.println("The pet with id "+ id+ "was deleted to the database");
        repository.deleteById(id);
        return "pet removed" +id;
    }

    public Pet updatePet(Pet pet)
    {
        System.out.println("The pet with id "+ pet.getId()+ "was updated in the database");
        Pet existingPet = repository.findById(pet.getId()).orElse(null);
        assert existingPet != null;
        existingPet.setName(pet.getName());
        existingPet.setMd(pet.getMd());
        existingPet.setAge(pet.getAge());
        existingPet.setBehaviour(pet.getBehaviour());
        existingPet.setSpecies(pet.getSpecies());
        return repository.save(existingPet);
    }



}
