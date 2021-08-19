import 'dart:convert';

StockSystem stockSystemFromJson(String str) {
  final jsonData = json.decode(str);
  return StockSystem.fromMap(jsonData);
}

String stockSystemToJson(StockSystem data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class StockSystem {
  int? id;
  int? productId;
  int? productLotId;
  int? emplacementId;
  int? quantity;


  StockSystem({
    this.id,
    this.productId,
    this.productLotId,
    this.emplacementId,
    this.quantity
  });

  factory StockSystem.fromMap(Map<String, dynamic> json) => new StockSystem(
    id: json["id"],
    productId: json["productId"],
    productLotId: json["productLotId"],
    emplacementId: json["emplacementId"],
    quantity: json["quantity"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "productId": productId,
    "productLotId": productLotId,
    "emplacementId": emplacementId,
    "quantity": quantity,

  };
}