import 'dart:convert';

InventoryLine inventoryLineFromJson(String str) {
  final jsonData = json.decode(str);
  return InventoryLine.fromMap(jsonData);
}

String inventoryLineToJson(InventoryLine data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class InventoryLine {
  int? id;
  int? inventoryId;
  int? productId;
  int? emplacementId;
  int? productLotId;

  int? quantity;
  int? quantitySystem;
  int? difference;
  String? quality;


  InventoryLine({
    this.id,
    this.inventoryId,
    this.productId,
    this.emplacementId,
    this.productLotId,

    this.quantity,
    this.quantitySystem,
    this.difference,
    this.quality,

  });

  factory InventoryLine.fromMap(Map<String, dynamic> json) => new InventoryLine(
    id: json["id"],
    inventoryId: json["inventoryId"],
    productId: json["productId"],
    emplacementId: json["emplacementId"],
    productLotId: json["productLotId"],

    quantity: json["quantity"],
    quantitySystem: json["quantitySystem"],
    difference: json["difference"],
    quality: json["quality"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "inventoryId": inventoryId,
    "productId": productId,
    "emplacementId": emplacementId,
    "productLotId": productLotId,

    "quantity": quantity,
    "quantitySystem": quantitySystem,
    "difference": difference,
    "quality": quality,
  };
}