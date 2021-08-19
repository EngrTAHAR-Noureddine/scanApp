import 'dart:convert';

StockEntrepot stockEntrepotFromJson(String str) {
  final jsonData = json.decode(str);
  return StockEntrepot.fromMap(jsonData);
}

String stockEntrepotToJson(StockEntrepot data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class StockEntrepot {
  int? id;
  String? nom;
  int? companyId;
  String? directionType;
  int? directionId;


  StockEntrepot({
    this.id,
    this.nom,
    this.companyId,
    this.directionType,
    this.directionId,

  });

  factory StockEntrepot.fromMap(Map<String, dynamic> json) => new StockEntrepot(
    id: json["id"],
    nom: json["nom"],
    companyId: json["companyId"],
    directionType: json["directionType"],
    directionId: json["directionId"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
    "companyId": companyId,
    "directionType": directionType,
    "directionId": directionId,

  };
}