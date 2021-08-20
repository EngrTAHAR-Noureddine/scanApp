import 'dart:convert';

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
  String? logoImage;

  String? phoneEnterprise;
  String? addressEnterprise;
  String? adminPassword;

  String? userPasswordReset;
  String? userPasswordActually;
  String? stateUser;
  String? sitesTable;

  String? companyTable;
  String? stockEnterpriseTable;
  String? stockSystemTable;
  String? bureauxTable;

  String? produitsTable;
  String? categoriesTable;
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
    this.stateUser,
    this.allProductLots,
    this.sitesTable,

    this.companyTable,
    this.stockEnterpriseTable,
    this.stockSystemTable,
    this.bureauxTable,

    this.produitsTable,
    this.categoriesTable,
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
      stateUser: json["stateUser"],
      allProductLots: json["allProductLots"],
      sitesTable: json["sitesTable"],

      companyTable: json["companyTable"],
      stockEnterpriseTable: json["stockEnterpriseTable"],
      stockSystemTable: json["stockSystemTable"],
      bureauxTable: json["bureauxTable"],

      produitsTable: json["produitsTable"],
      categoriesTable: json["categoriesTable"],
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
    "stateUser": stateUser,
    "allProductLots": allProductLots,
    "sitesTable": sitesTable,

    "companyTable": companyTable,
    "stockEnterpriseTable": stockEnterpriseTable,
    "stockSystemTable": stockSystemTable,
    "bureauxTable": bureauxTable,

    "produitsTable": produitsTable,
    "categoriesTable": categoriesTable,
    "productLotsTable": productLotsTable,

  };
}