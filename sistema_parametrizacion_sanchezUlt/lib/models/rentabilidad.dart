import 'dart:convert';

class Rentabilidad {
  Rentabilidad({
    required this.id,
    required this.planningSowing2Id,
    required this.costRecordId,
    required this.planningSowing2,
    required this.costRecord,
  });

  int id;
  int planningSowing2Id;
  int costRecordId;
  PlanningSowing2 planningSowing2;
  CostRecord costRecord;

  factory Rentabilidad.fromJson(String str) =>
      Rentabilidad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rentabilidad.fromMap(Map<String, dynamic> json) => Rentabilidad(
        id: json["id"],
        planningSowing2Id: json["planningSowing2Id"],
        costRecordId: json["costRecordId"],
        planningSowing2: PlanningSowing2.fromMap(json["planningSowing2"]),
        costRecord: CostRecord.fromMap(json["costRecord"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "planningSowing2Id": planningSowing2Id,
        "costRecordId": costRecordId,
        "planningSowing2": planningSowing2.toMap(),
        "costRecord": costRecord.toMap(),
      };
}

class PlanningSowing2 {
  PlanningSowing2({
    required this.id,
    required this.sowingDate,
    required this.sowingDateEnd,
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
  int estimatedSowingTime;
  int numberOfBunches;
  int rejectedBunches;
  double averageBunchWeight;
  int batchNumber;
  int planningSowing1Id;

  factory PlanningSowing2.fromMap(Map<String, dynamic> json) => PlanningSowing2(
        id: json["id"],
        sowingDate: DateTime.parse(json["sowingDate"]),
        sowingDateEnd: DateTime.parse(json["sowingDateEnd"]),
        estimatedSowingTime: json["estimatedSowingTime"],
        numberOfBunches: json["numberOfBunches"],
        rejectedBunches: json["rejectedBunches"],
        averageBunchWeight: json["averageBunchWeight"].toDouble(),
        batchNumber: json["batchNumber"],
        planningSowing1Id: json["planningSowing1Id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sowingDate": sowingDate.toIso8601String(),
        "sowingDateEnd": sowingDateEnd.toIso8601String(),
        "estimatedSowingTime": estimatedSowingTime,
        "numberOfBunches": numberOfBunches,
        "rejectedBunches": rejectedBunches,
        "averageBunchWeight": averageBunchWeight,
        "batchNumber": batchNumber,
        "planningSowing1Id": planningSowing1Id,
      };
}

class CostRecord {
  CostRecord({
    required this.id,
    required this.registerDate,
    required this.description,
    required this.input,
    required this.labor,
    required this.fuel,
    required this.totalCosts,
    required this.inventoryId,
    required this.operationalUserId,
  });

  int id;
  DateTime registerDate;
  String description;
  int input;
  int labor;
  int fuel;
  int totalCosts;
  int inventoryId;
  int operationalUserId;

  factory CostRecord.fromMap(Map<String, dynamic> json) => CostRecord(
        id: json["id"],
        registerDate: DateTime.parse(json["registerDate"]),
        description: json["description"],
        input: json["input"],
        labor: json["labor"],
        fuel: json["fuel"],
        totalCosts: json["totalCosts"],
        inventoryId: json["inventoryId"],
        operationalUserId: json["operationalUserId"],
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
        "operationalUserId": operationalUserId,
      };
}
