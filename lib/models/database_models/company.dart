import 'dart:convert';

Company companyFromJson(String str) {
  final jsonData = json.decode(str);
  return Company.fromMap(jsonData);
}

String companyToJson(Company data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Company {
  int? id;
  String? nom;
  int? siteId;
  String? logo;


  Company({
    this.id,
    this.nom,
    this.siteId,
    this.logo,

  });

  factory Company.fromMap(Map<String, dynamic> json) => new Company(
    id: json["id"],
    nom: json["nom"],
    siteId: json["siteId"],
    logo: json["logo"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
    "siteId": siteId,
    "logo": logo,

  };
}