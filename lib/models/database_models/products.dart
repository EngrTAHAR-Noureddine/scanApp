import 'dart:convert';

Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromMap(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Product {
  int? id;
  String? nom;
  String? productCode;
  int? categoryId;
  String? gestionLot;
  String? productType;

  Product({
    this.id,
    this.nom,
    this.productCode,
    this.categoryId,
    this.gestionLot,
    this.productType
  });

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
    id: json["id"],
    nom: json["nom"],
    productCode: json["productCode"],
    categoryId: json["categoryId"],
    gestionLot: json["gestionLot"],
    productType: json["productType"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
    "productCode": productCode,
    "categoryId": categoryId,
    "gestionLot": gestionLot,
    "productType": productType,

  };
}