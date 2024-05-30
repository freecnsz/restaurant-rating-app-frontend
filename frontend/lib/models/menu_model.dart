import 'dart:convert';

class BaseMenuModel {
  bool? succeeded;
  String? message;
  List<String>? errors;
  List<MenuModel>? data;
  int? pageNumber;
  int? pageSize;

  BaseMenuModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
    this.pageNumber,
    this.pageSize,
  });

  factory BaseMenuModel.fromJson(Map<String, dynamic> json) => BaseMenuModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        data: json["data"] == null
            ? []
            : List<MenuModel>.from(
                json["data"]!.map((x) => MenuModel.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
      );
}

class MenuModel {
  int? id;
  String? name;
  String? description;
  int? menuRate;
  int? menuRateCount;
  bool? isEnabled;
  bool? isShowned;
  String? placeName;
  String? menuTypeName;

  MenuModel({
    this.id,
    this.name,
    this.description,
    this.menuRate,
    this.menuRateCount,
    this.isEnabled,
    this.isShowned,
    this.placeName,
    this.menuTypeName,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        menuRate: json["menuRate"],
        menuRateCount: json["menuRateCount"],
        isEnabled: json["isEnabled"],
        isShowned: json["isShowned"],
        placeName: json["placeName"],
        menuTypeName: json["menuTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "menuRate": menuRate,
        "menuRateCount": menuRateCount,
        "isEnabled": isEnabled,
        "isShowned": isShowned,
        "placeName": placeName,
        "menuTypeName": menuTypeName,
      };
}
