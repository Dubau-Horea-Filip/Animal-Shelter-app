// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/Update.dart';
import 'package:flutter_animal_shelter/add.dart';
import 'package:flutter_animal_shelter/messageResponse.dart';
import 'Services/Database_Helper.dart';
import 'ce.dart';
import 'models/Pet_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final String _title;

  const MyHomePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => _MyhomePage();
}

class _MyhomePage extends State<MyHomePage> {
  List<Pet> _pets = [];

  // final List<Pet> _pets = [
  //   Pet(
  //       name: "Rio",
  //       age: 2,
  //       species: "Orange Tabby cat",
  //       medical_records: "vaccinated",
  //       behaviour: "needy"),
  //   Pet(
  //       name: "Fio",
  //       age: 3,
  //       species: "cat",
  //       medical_records: "unknow",
  //       behaviour: "nice"),
  //   Pet(
  //       name: "Max",
  //       age: 1,
  //       species: "dog",
  //       medical_records: "vaccinated",
  //       behaviour: "playfull"),
  // ];

  // List<Pet> _pets = [
  //   Pet("Rio", "2", "Orange Tabby cat", "vaccinated", "needy"),
  //   Pet("Fio", "3", "cat", "unknow", "nice"),
  //   Pet("Max", "1", "dog", "vaccinated", "playfull"),
  // ];

  //This function is used to fetch all data from the database
  void _refresh() async {
    try {
      var client = http.Client();
      const url = 'http://10.0.2.2:9191/pets';
      final uri = Uri.parse(url);
      final response = await client.get(uri).timeout(const Duration(seconds: 2));
      final body = response.body;
      final json = jsonDecode(body);
      List<Pet> _data = [];
      setState(() {
        List<dynamic> pets = [];
        pets = json;
        var size = pets.length;
        var index = 0;
        for (index; index < size; index++) {
          final name = json[index]['name'];
          final id = json[index]['id'];
          final age = json[index]['age'];
          final species = json[index]['species'];
          final behaviour = json[index]['behaviour'];
          final md = json[index]['md'];
          Pet pet = Pet(
              id: id,
              name: name,
              age: age,
              behaviour: behaviour,
              md: md,
              species: species);
          _data.add(pet);
        }
        _pets = _data;
      });
    } on Exception {
      // log.severe(ex);
      throw Exception("could not fetch data");
    }

    // final data = await DataBaseHelper.getPets();
    // setState(() {
    //   _pets = data!;
    // });
  }

  void refresh() async {
    setState(() {
      List<dynamic> pets = [];
      List<Pet> _data = _pets;
    });
  }

  @override
  void initState() {
    super.initState();

    // DataBaseHelper.addPet(Pet(
    //     name: "Rio",
    //     age: 2,
    //     species: "Orange Tabby cat",
    //     MD: "vaccinated",
    //     behaviour: "needy",
    //     id: 1));
    //
    // DataBaseHelper.addPet(Pet(
    //     name: "Fio",
    //     age: 3,
    //     species: "cat",
    //     MD: "vaccinated",
    //     behaviour: "nice",
    //     id: 2));
    try {
      _refresh(); // Loading the diary when the app starts
    } catch (e) {
      print("am intrat 2");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                  "There was an error while trying to reach the server "),
              content: Text(e.toString()));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
          itemCount: _pets.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Update(_pets[index])))
                    .then((newObject) async {
                  if (newObject != null) {
                    try {
                      await DataBaseHelper.updatePet(newObject);
                      setState(() async {
                        //_refresh();
                        refresh();
                        _pets.removeAt(index);
                        _pets.insert(index, newObject);
                        messageRrsponse(
                            context, newObject.name + " was updated");
                      });
                    } on Database_Exception catch (e) {
                      print("am intrat");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                  "There was an error while trying to reach the server "),
                              content: Text(e.cause.toString()));
                        },
                      );
                    }
                  }
                });
              },
              onLongPress: () {
                removeObject(context, index, _pets[index].name);
              },
              title: Text(_pets[index].name),
              subtitle: Text("${_pets[index].species}\n${_pets[index].age}"),
              leading: CircleAvatar(
                child: Text(_pets[index].name.substring(0, 1)),
              ),
              trailing: const Icon(
                Icons.info,
                color: Colors.blue,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const addPet()))
              .then((Object) async {
            if (Object != null) {
              try {
                await DataBaseHelper.addPet(Object);
                setState(() async {
                  //_refresh();
                  refresh();
                  _pets.add(Object);
                  // ignore: use_build_context_synchronously
                  messageRrsponse(context, Object.name + " was added");
                });
              } on Database_Exception catch (e) {
                print("am intrat");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text(
                            "There was an error while trying to reach the server "),
                        content: Text(e.cause.toString()));
                  },
                );
              }
            }
          });
        },
        tooltip: "add",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeObject(BuildContext context, var index, var name) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("are you sure you want to delete this pet?"),
              content: Text("The pet  $name will be eliminated"),
              actions: [
                TextButton(
                    onPressed: () async {
                      try {
                        await DataBaseHelper.deletePet(_pets[index]);
                        setState(() async {
                          //_refresh();
                          refresh();
                          _pets.removeAt(index);
                          Navigator.pop(context);
                        });
                      } on Database_Exception catch (e) {
                        print("am intrat");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text(
                                    "There was an error while trying to reach the server "),
                                content: Text(e.cause.toString()));
                          },
                        );
                      }
                    },
                    child: const Text("Eliminate",
                        style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      _refresh();
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}
