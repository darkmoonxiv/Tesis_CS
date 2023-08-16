import 'dart:convert';

class Permisos {
  Permisos({
    required this.id,
    required this.permissionName,
    required this.description,

  });

  int id;
  String permissionName;
  String description;


  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        id: json["id"],
        permissionName: json["permissionName"],
        description: json["description"],

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "permissionName": permissionName,
        "description": description,

      };
}

