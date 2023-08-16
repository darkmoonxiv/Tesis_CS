import 'dart:convert';

class Usuario {
  Usuario({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.state,
    required this.roles,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String state;
  List<Rol> roles;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        state: json["state"],
        roles: List<Rol>.from(json["roles"].map((x) => Rol.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "state": state,
        "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
      };
}

class Rol {
  Rol({
    required this.id,
    required this.roleName,
    required this.roleCode,
  });

  int id;
  String roleName;
  String roleCode;

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
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
