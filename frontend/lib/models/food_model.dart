import 'dart:convert';

class BaseFoodModel {
  int? pageNumber;
  int? pageSize;
  bool? succeeded;
  dynamic message;
  dynamic errors;
  List<FoodModel>? data;

  BaseFoodModel({
    this.pageNumber,
    this.pageSize,
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory BaseFoodModel.fromJson(Map<String, dynamic> json) => BaseFoodModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null
            ? []
            : List<FoodModel>.from(
                json["data"]!.map((x) => FoodModel.fromJson(x))),
      );
}

class FoodModel {
  int? id;
  String? name;
  String? description;
  String? foodImage;
  double? price;
  int? commentCount;
  double? ratePoint;
  int? rateCount;
  bool? isEnabled;
  bool? isShowned;
  String? foodTypeName;
  String? menuName;
  String? placeName;

  FoodModel({
    this.id,
    this.name,
    this.description,
    this.foodImage,
    this.price,
    this.commentCount,
    this.ratePoint,
    this.rateCount,
    this.isEnabled,
    this.isShowned,
    this.foodTypeName,
    this.menuName,
    this.placeName,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        foodImage: json["foodImage"],
        price: json["price"],
        commentCount: json["commentCount"],
        ratePoint: json["ratePoint"],
        rateCount: json["rateCount"],
        isEnabled: json["isEnabled"],
        isShowned: json["isShowned"],
        foodTypeName: json["foodTypeName"],
        menuName: json["menuName"],
        placeName: json["placeName"],
      );
}
