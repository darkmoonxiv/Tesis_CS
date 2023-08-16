import 'dart:convert';

class Reporte {
  Reporte({
    required this.id,
    required this.userId,
    required this.reportTypeId,
    required this.content,
    required this.creationDate,
  });

  int id;
  int userId;
  int reportTypeId;
  String content;
  DateTime creationDate;

  factory Reporte.fromJson(String str) => Reporte.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reporte.fromMap(Map<String, dynamic> json) => Reporte(
        id: json["id"],
        userId: json["userId"],
        reportTypeId: json["reportTypeId"],
        content: json["content"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "reportTypeId": reportTypeId,
        "content": content,
        "creationDate": creationDate.toIso8601String(),
      };
}
