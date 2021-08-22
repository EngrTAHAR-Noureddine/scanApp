import 'dart:convert';

import 'dart:typed_data';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  int? id;
  int? allProductLots;

  String? logoName;
  Uint8List? logoImage;

  String? phoneEnterprise;
  String? addressEnterprise;

  String? adminPassword;
  String? userPasswordReset;

  String? userPasswordActually;
  String? isDark;

  String? productLotsTable;

  User({
    this.id,
    this.logoName,
    this.logoImage,
    this.phoneEnterprise,

    this.addressEnterprise,
    this.adminPassword,
    this.userPasswordReset,

    this.userPasswordActually,
    this.isDark, //dark - light
    this.allProductLots,
    this.productLotsTable
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
      id: json["id"],
      logoName: json["logoName"],
      logoImage: json["logoImage"],
      phoneEnterprise: json["phoneEnterprise"],

      addressEnterprise: json["addressEnterprise"],
      adminPassword: json["adminPassword"],
      userPasswordReset: json["userPasswordReset"],

      userPasswordActually: json["userPasswordActually"],
      isDark: json["isDark"],
      allProductLots: json["allProductLots"],

      productLotsTable: json["productLotsTable"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "logoName": logoName,
    "logoImage": logoImage,
    "phoneEnterprise": phoneEnterprise,

    "addressEnterprise": addressEnterprise,
    "adminPassword": adminPassword,
    "userPasswordReset": userPasswordReset,

    "userPasswordActually": userPasswordActually,
    "isDark": isDark,
    "allProductLots": allProductLots,
    "productLotsTable": productLotsTable,

  };
}