import 'dart:convert';

Inventory inventoryFromJson(String str) {
  final jsonData = json.decode(str);
  return Inventory.fromMap(jsonData);
}

String inventoryToJson(Inventory data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Inventory {
  int? id;
  String? openingDate;
  String? closeDate;


  Inventory({
    this.id,
    this.openingDate,
    this.closeDate,

  });

  factory Inventory.fromMap(Map<String, dynamic> json) => new Inventory(
    id: json["id"],
    openingDate: json["openingDate"],
    closeDate: json["closeDate"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "openingDate": openingDate,
    "closeDate": closeDate,

  };
}