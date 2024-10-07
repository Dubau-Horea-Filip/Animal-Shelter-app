class Pet {
  int? id;
  String name = "";
  int? age = 0;
  String species = "";
  String behaviour = "";
  String md = "";

  Pet(
      {required this.name,
      required this.age,
      required this.behaviour,
      required this.md,
      required this.species,
      this.id});

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      species: json['species'],
      behaviour: json['behaviour'],
      md: json['MD']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'species': species,
        'behaviour': behaviour,
        'MD': md
      };
}
