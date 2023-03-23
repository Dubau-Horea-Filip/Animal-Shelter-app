// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';


//void main() => runApp( Shelter());

class Shelter extends StatelessWidget {
  //DogService service;
  //Shelter(DogService service);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shelter",
      home: MyHomePage("Pets"),
    );
  }
}
