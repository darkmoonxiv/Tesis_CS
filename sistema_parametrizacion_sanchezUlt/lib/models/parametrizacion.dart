import 'dart:convert';

class Parametrizacion {
  Parametrizacion({
    required this.id,
    required this.sowingDate,
    required this.sowingDateEnd,
    required this.climaticCondition,
    required this.seedName,
    required this.bananaVariety,
    required this.fertilizerQuantityKG,
    required this.pesticideQuantityKG,
    required this.fumigationDate,
    required this.irrigation,
    required this.operationalUserId,
    required this.estimatedSowingTime,
    required this.numberOfBunches,
    required this.rejectedBunches,
    required this.averageBunchWeight,
    required this.batchNumber,
    required this.planningSowing1Id,
  });

  int id;
  DateTime sowingDate;
  DateTime sowingDateEnd;
  String climaticCondition;
  String seedName;
  String bananaVariety;
  double fertilizerQuantityKG;
  double pesticideQuantityKG;
  DateTime fumigationDate;
  String irrigation;
  int operationalUserId;
  int estimatedSowingTime;
  int numberOfBunches;
  int rejectedBunches;
  double averageBunchWeight;
  int batchNumber;
  int planningSowing1Id;

  factory Parametrizacion.fromJson(String str) =>
      Parametrizacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Parametrizacion.fromMap(Map<String, dynamic> json) => Parametrizacion(
        id: json["planningSowing1"]["id"],
        sowingDate: DateTime.parse(json["planningSowing2"]["sowingDate"]),
        sowingDateEnd: DateTime.parse(json["planningSowing2"]["sowingDateEnd"]),
        climaticCondition: json["planningSowing1"]["climaticCondition"],
        seedName: json["planningSowing1"]["seedName"],
        bananaVariety: json["planningSowing1"]["bananaVariety"],
        fertilizerQuantityKG: json["planningSowing1"]["fertilizerQuantityKG"].toDouble(),
        pesticideQuantityKG: json["planningSowing1"]["pesticideQuantityKG"].toDouble(),
        fumigationDate: DateTime.parse(json["planningSowing1"]["fumigationDate"]),
        irrigation: json["planningSowing1"]["irrigation"],
        operationalUserId: json["planningSowing1"]["operationalUserId"],
        estimatedSowingTime: json["planningSowing2"]["estimatedSowingTime"],
        numberOfBunches: json["planningSowing2"]["numberOfBunches"],
        rejectedBunches: json["planningSowing2"]["rejectedBunches"],
        averageBunchWeight: json["planningSowing2"]["averageBunchWeight"].toDouble(),
        batchNumber: json["planningSowing2"]["batchNumber"],
        planningSowing1Id: json["planningSowing2"]["planningSowing1Id"],
      );

  Map<String, dynamic> toMap() => {
        "planningSowing1": {
          "id": id,
          "climaticCondition": climaticCondition,
          "seedName": seedName,
          "bananaVariety": bananaVariety,
          "fertilizerQuantityKG": fertilizerQuantityKG,
          "pesticideQuantityKG": pesticideQuantityKG,
          "fumigationDate": fumigationDate.toIso8601String(),
          "irrigation": irrigation,
          "operationalUserId": operationalUserId,
        },
        "planningSowing2": {
          "sowingDate": sowingDate.toIso8601String(),
          "sowingDateEnd": sowingDateEnd.toIso8601String(),
          "estimatedSowingTime": estimatedSowingTime,
          "numberOfBunches": numberOfBunches,
          "rejectedBunches": rejectedBunches,
          "averageBunchWeight": averageBunchWeight,
          "batchNumber": batchNumber,
          "planningSowing1Id": planningSowing1Id,
        },
      };
}
