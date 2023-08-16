import 'dart:convert';

class Roles {
  Roles({
    required this.id,
    required this.roleName,
    required this.roleCode,

  });

  int id;
  String roleName;
  String roleCode;


  factory Roles.fromJson(String str) => Roles.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Roles.fromMap(Map<String, dynamic> json) => Roles(
        id: json["id"],
        roleName: json["roleName"],
        roleCode: json["roleCode"],

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "roleName": roleName,
        "roleCode": roleCode,

      };
}

