import 'dart:convert';

class ReporteTipo {
  ReporteTipo({
    required this.id,

    required this.reportName,

  });

  int id;

  String reportName;


  factory ReporteTipo.fromJson(String str) => ReporteTipo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReporteTipo.fromMap(Map<String, dynamic> json) => ReporteTipo(
        id: json["id"],

        reportName: json["reportName"],

      );

  Map<String, dynamic> toMap() => {
        "id": id,

        "reportName": reportName,

      };
}
