// To parse this JSON data, do
//
//     final lotes = lotesFromMap(jsonString);

import 'dart:convert';

class Lotes {
    bool estadoRevision;
    bool estado;
    String id;
    String nombre;
    String codigo;
    String modelo;
    int stock;
    Usuario usuario;
    DateTime fechaIngreso;

    Lotes({
        required this.estadoRevision,
        required this.estado,
        required this.id,
        required this.nombre,
        required this.codigo,
        required this.modelo,
        required this.stock,
        required this.usuario,
        required this.fechaIngreso,
    });

    factory Lotes.fromJson(String str) => Lotes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Lotes.fromMap(Map<String, dynamic> json) => Lotes(
        estadoRevision: json["estadoRevision"],
        estado: json["estado"],
        id: json["_id"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        modelo: json["modelo"],
        stock: json["stock"],
        usuario: Usuario.fromMap(json["usuario"]),
        fechaIngreso: DateTime.parse(json["fechaIngreso"]),
    );

    Map<String, dynamic> toMap() => {
        "estadoRevision": estadoRevision,
        "estado": estado,
        "_id": id,
        "nombre": nombre,
        "codigo": codigo,
        "modelo": modelo,
        "stock": stock,
        "usuario": usuario.toMap(),
        "fechaIngreso": fechaIngreso.toIso8601String(),
    };
    @override
  String toString() {
    return 'Lotes: ${ this.modelo }';
  }
}


class Usuario {
    String id;
    String nombre;

    Usuario({
        required this.id,
        required this.nombre,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}
