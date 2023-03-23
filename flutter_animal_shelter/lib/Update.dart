// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/textbox.dart';



import 'models/Pet_model.dart';

class Update extends StatefulWidget {
  final Pet _pet;

  const Update(
    this._pet, {super.key}
  );

  @override
  State<StatefulWidget> createState() => _Update();
} // end Update class

class _Update extends State<Update> {
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerSpecies;
  late TextEditingController controllerBehaviour;
  late TextEditingController controllerMD;

  @override
  void initState() {
    Pet c = widget._pet;
    controllerName = TextEditingController(text: c.name);
    controllerAge = TextEditingController(text: c.age.toString());
    controllerSpecies = TextEditingController(text: c.species);
    controllerBehaviour = TextEditingController(text: c.behaviour);
    controllerMD = TextEditingController(text: c.md);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Object"),
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
                      //Pet(name, age, species, behaviour, md));
                      Pet(
                          id: widget._pet.id,
                          name: name,
                          species: species,
                          behaviour: behaviour,
                          age: int.parse(age),
                          md: md));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                            //title: Text("opa"),
                            content: Text(
                                "All filds shoud be filled and age shoud be a number"),
                          ));
                }
              },
              child: const Text("update pet"))
        ],
      ),
    );
  }

  bool _isNumeric(String str) {
    // ignore: unnecessary_null_comparison
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}// end _Update class