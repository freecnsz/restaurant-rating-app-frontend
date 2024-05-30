class FoodTypeModel {
  int? pageNumber;
  int? pageSize;
  bool? succeeded;
  dynamic message;
  dynamic errors;
  List<FoodType>? data;

  FoodTypeModel({
    this.pageNumber,
    this.pageSize,
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory FoodTypeModel.fromJson(Map<String, dynamic> json) => FoodTypeModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null
            ? []
            : List<FoodType>.from(
                json["data"]!.map((x) => FoodType.fromJson(x))),
      );
}

class FoodType {
  int? id;
  String? name;

  FoodType({
    this.id,
    this.name,
  });

  factory FoodType.fromJson(Map<String, dynamic> json) => FoodType(
        id: json["id"],
        name: json["name"],
      );
}
