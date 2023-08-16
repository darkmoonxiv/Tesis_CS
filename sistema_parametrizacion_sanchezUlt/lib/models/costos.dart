import 'dart:convert';

class Costos {
  Costos({
    required this.id,
    required this.registerDate,
    required this.description,
    required this.input,
    required this.labor,
    required this.fuel,
    required this.totalCosts,
    required this.inventoryId,

  });

  int id;
  DateTime registerDate;
  String description;
  double input;
  double labor;
  double fuel;
  double totalCosts;
  int inventoryId;


  factory Costos.fromJson(String str) => Costos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Costos.fromMap(Map<String, dynamic> json) => Costos(
        id: json["id"],
        registerDate: DateTime.parse(json["registerDate"]),
        description: json["description"],
        input: json["input"].toDouble(),
        labor: json["labor"].toDouble(),
        fuel: json["fuel"].toDouble(),
        totalCosts: json["totalCosts"].toDouble(),
        inventoryId: json["inventoryId"],

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "registerDate": registerDate.toIso8601String(),
        "description": description,
        "input": input,
        "labor": labor,
        "fuel": fuel,
        "totalCosts": totalCosts,
        "inventoryId": inventoryId,

      };
}
