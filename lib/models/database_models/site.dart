import 'dart:convert';

Site siteFromJson(String str) {
  final jsonData = json.decode(str);
  return Site.fromMap(jsonData);
}

String siteToJson(Site data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Site {
  int? id;
  String? nom;


  Site({
    this.id,
    this.nom,

  });

  factory Site.fromMap(Map<String, dynamic> json) => new Site(
    id: json["id"],
    nom: json["nom"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,

  };
}