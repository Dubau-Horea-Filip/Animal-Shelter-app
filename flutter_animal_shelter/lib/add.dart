import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/textbox.dart';

import 'models/pet_model.dart';

class addPet extends StatefulWidget {
  final Pet? pet;
  const addPet({super.key, this.pet});
  @override
  State<StatefulWidget> createState() => _addPet();
}

class _addPet extends State<addPet> {
  late TextEditingController controllerName;
  late TextEditingController controllerSpecies;
  late TextEditingController controllerAge;
  late TextEditingController controllerBehaviour;
  late TextEditingController controllerMD;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerAge = TextEditingController();
    controllerSpecies = TextEditingController();
    controllerBehaviour = TextEditingController();
    controllerMD = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add an object"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Name"),
          TextBox(controllerAge, "age"),
          TextBox(controllerSpecies, "species"),
          TextBox(controllerBehaviour, "behaviour"),
          TextBox(controllerMD, "Mediacl Records"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String age = controllerAge.text;
                String species = controllerSpecies.text;
                String behaviour = controllerBehaviour.text;
                String md = controllerMD.text;
                if (name.isNotEmpty &&
                    age.isNotEmpty &&
                    _isNumeric(age) &&
                    species.isNotEmpty &&
                    behaviour.isNotEmpty &&
                    md.isNotEmpty) {
                  Navigator.pop(
                      context,
                      Pet(
                          name: name,
                          species: species,
                          behaviour: behaviour,
                          age: int.parse(age),
                          md: md,
                          id: widget.pet?.id));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                            content: Text(
                                "All filds shoud be filled and age shoud be a number"),
                          ));
                }
              },
              child: const Text("add pet"))
        ],
      ),
    );
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}
