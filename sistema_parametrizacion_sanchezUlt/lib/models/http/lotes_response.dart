// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);
import 'dart:convert';

import 'package:admin_dashboard/models/lotes.dart';



class LotesResponse {
    LotesResponse({
        required this.total,
        required this.lotes,
    });

    int total;
    List<Lotes> lotes;

    factory LotesResponse.fromJson(String str) => LotesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LotesResponse.fromMap(Map<String, dynamic> json) => LotesResponse(
        total: json["total"],
        lotes: List<Lotes>.from(json["lotes"].map((x) => Lotes.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "lotes": List<dynamic>.from(lotes.map((x) => x.toMap())),
    };
}


