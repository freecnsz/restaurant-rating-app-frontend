class SingleFoodModel {
  bool? succeeded;
  dynamic message;
  dynamic errors;
  Data? data;

  SingleFoodModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory SingleFoodModel.fromJson(Map<String, dynamic> json) =>
      SingleFoodModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "succeeded": succeeded,
        "message": message,
        "errors": errors,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? description;
  String? foodImage;
  int? price;
  int? commentCount;
  int? ratePoint;
  int? rateCount;
  bool? isEnabled;
  bool? isShowned;
  String? foodTypeName;
  String? menuName;
  String? placeName;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "foodImage": foodImage,
        "price": price,
        "commentCount": commentCount,
        "ratePoint": ratePoint,
        "rateCount": rateCount,
        "isEnabled": isEnabled,
        "isShowned": isShowned,
        "foodTypeName": foodTypeName,
        "menuName": menuName,
        "placeName": placeName,
      };
}
