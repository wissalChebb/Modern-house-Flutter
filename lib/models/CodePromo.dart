// To parse this JSON data, do
//
//     final codePromo = codePromoFromJson(jsonString);

import 'dart:convert';

CodePromo codePromoFromJson(String str) => CodePromo.fromJson(json.decode(str));

String codePromoToJson(CodePromo data) => json.encode(data.toJson());
CodePromo? c = CodePromo(discount: 0, active: true);

class CodePromo {
  int discount;
  bool active;

  CodePromo({
    required this.discount,
    required this.active,
  });

  factory CodePromo.fromJson(Map<String, dynamic> json) => CodePromo(
        discount: json["discount"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "discount": discount,
        "active": active,
      };
}
