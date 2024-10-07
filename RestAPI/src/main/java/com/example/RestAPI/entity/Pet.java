package com.example.RestAPI.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "Pets")
public class Pet {

    @Id
    @GeneratedValue
    int id;
    String name;
    int age;
    String species = "";
    String behaviour = "";
    String md = "";

    public Pet(int id, String name, int age, String species, String behaviour, String MD) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.species = species;
        this.behaviour = behaviour;
        this.md = MD;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getSpecies() {
        return species;
    }

    public String getBehaviour() {
        return behaviour;
    }

    public String getMd() {
        return md;
    }
}