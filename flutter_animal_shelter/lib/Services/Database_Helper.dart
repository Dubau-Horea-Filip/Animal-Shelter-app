import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../ce.dart';
import '../models/pet_model.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _DBname = "Pets.db";

  static String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:9191';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:9191';
    } else if (Platform.isIOS) {
      return 'http://localhost:9191';
    } else {
      return 'http://localhost:9191';
    }
  }

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _DBname),
        onCreate: (db, version) async => await db.execute("""CREATE TABLE Pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age INTEGER,
        species TEXT,
        behaviour TEXT,
        MD TEXT
      );
      """), version: _version);
  }

  static Future<void> addPet(Pet pet) async {
    try {
      String baseUrl = getBaseUrl();
      var response = await http.post(Uri.parse('$baseUrl/addPet'), body: {
        "name": pet.name,
        "age": pet.age.toString(),
        "species": pet.species,
        "behaviour": pet.behaviour,
        "md": pet.md
      }).timeout(const Duration(seconds: 1));
      if (response.statusCode != 200) {
        throw Exception("There was an error while trying to reach the server ");
      }
    } catch (ex) {
      throw Database_Exception("Couldn't add pet");
    }
  }

  static Future<void> updatePet(Pet pet) async {
    try {
      String baseUrl = getBaseUrl(); // Get the correct base URL
      await http.put(Uri.parse('$baseUrl/updatePet'), body: {
        "id": pet.id.toString(),
        "name": pet.name,
        "age": pet.age.toString(),
        "species": pet.species,
        "behaviour": pet.behaviour,
        "md": pet.md
      }).timeout(const Duration(seconds: 1));
    } catch (ex) {
      throw Database_Exception(
          "There was an error while trying to update the pet");
    }
  }

  static Future<void> deletePet(Pet pet) async {
    try {
      String baseUrl = getBaseUrl(); // Get the correct base URL
      await http
          .delete(Uri.parse('$baseUrl/delete/${pet.id}'))
          .timeout(const Duration(seconds: 1));
    } catch (ex) {
      throw Database_Exception(
          "There was an error while trying to delete the pet");
    }
  }

  static Future<List<Pet>?> getPets() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Pets");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Pet.fromJson(maps[index]));
  }
}
