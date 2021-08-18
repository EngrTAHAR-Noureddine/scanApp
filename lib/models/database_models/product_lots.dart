import 'dart:convert';

ProductLot productLotFromJson(String str) {
  final jsonData = json.decode(str);
  return ProductLot.fromMap(jsonData);
}

String productLotToJson(ProductLot data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ProductLot {
  int id;
  int productId;
  String numLot;
  String numSerie;
  String immatriculation;

  ProductLot({
    this.id,
    this.productId,
    this.numLot,
    this.numSerie,
    this.immatriculation,

  });

  factory ProductLot.fromMap(Map<String, dynamic> json) => new ProductLot(
    id: json["id"],
    productId: json["productId"],
    numLot: json["numLot"],
    numSerie: json["numSerie"],
    immatriculation: json["immatriculation"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "productId": productId,
    "numLot": numLot,
    "numSerie": numSerie,
    "immatriculation": immatriculation,


  };
}