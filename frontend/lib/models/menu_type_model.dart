class BaseMenuTypeModel {
  int? pageNumber;
  int? pageSize;
  bool? succeeded;
  dynamic message;
  dynamic errors;
  List<MenuTypeModel>? data;

  BaseMenuTypeModel({
    this.pageNumber,
    this.pageSize,
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory BaseMenuTypeModel.fromJson(Map<String, dynamic> json) =>
      BaseMenuTypeModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null
            ? []
            : List<MenuTypeModel>.from(
                json["data"]!.map((x) => MenuTypeModel.fromJson(x))),
      );
}

class MenuTypeModel {
  int? id;
  String? name;

  MenuTypeModel({
    this.id,
    this.name,
  });

  factory MenuTypeModel.fromJson(Map<String, dynamic> json) => MenuTypeModel(
        id: json["id"],
        name: json["name"],
      );
}
