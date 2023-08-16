import 'dart:convert';

class Inventario {
  Inventario({
    required this.id,
    required this.purchaseDate,
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  int id;
  DateTime purchaseDate;
  String product;
  int quantity;
  double unitPrice;

  factory Inventario.fromJson(String str) => Inventario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Inventario.fromMap(Map<String, dynamic> json) => Inventario(
        id: json["id"],
        purchaseDate: DateTime.parse(json["purchaseDate"]),
        product: json["product"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "purchaseDate": purchaseDate.toIso8601String(),
        "product": product,
        "quantity": quantity,
        "unitPrice": unitPrice,
      };
}
