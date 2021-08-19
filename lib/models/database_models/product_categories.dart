import 'dart:convert';

ProductCategory productCategoryFromJson(String str) {
  final jsonData = json.decode(str);
  return ProductCategory.fromMap(jsonData);
}

String productCategoryToJson(ProductCategory data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ProductCategory {
  int? id;
  String? categoryName;
  String? categoryCode;
  int? parentId;
  String? parentPath;

  ProductCategory({
    this.id,
    this.categoryName,
    this.categoryCode,
    this.parentId,
    this.parentPath
  });

  factory ProductCategory.fromMap(Map<String, dynamic> json) => new ProductCategory(
    id: json["id"],
    categoryName: json["categoryName"],
    categoryCode: json["categoryCode"],
    parentId: json["parentId"],
    parentPath: json["parentPath"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "categoryName": categoryName,
    "categoryCode": categoryCode,
    "parentId": parentId,
    "parentPath": parentPath,

  };
}