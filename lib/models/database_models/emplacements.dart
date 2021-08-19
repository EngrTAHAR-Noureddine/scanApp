import 'dart:convert';

Emplacement emplacementFromJson(String str) {
  final jsonData = json.decode(str);
  return Emplacement.fromMap(jsonData);
}

String emplacementToJson(Emplacement data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Emplacement {
  int? id;
  String? nom;
  int? entrepotId;
  String? barCodeEmp;


  Emplacement({
    this.id,
    this.nom,
    this.entrepotId,
    this.barCodeEmp

  });

  factory Emplacement.fromMap(Map<String, dynamic> json) => new Emplacement(
    id: json["id"],
    nom: json["nom"],
    entrepotId: json["entrepotId"],
    barCodeEmp: json["barcodeemp"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
    "entrepotId": entrepotId,
    "barcodeemp": barCodeEmp,
  };
}