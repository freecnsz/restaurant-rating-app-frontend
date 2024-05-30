class PlaceTypeModel {
  bool? succeeded;
  String? message;
  List<String>? errors;
  List<Datum>? data;
  int? pageNumber;
  int? pageSize;

  PlaceTypeModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
    this.pageNumber,
    this.pageSize,
  });

  factory PlaceTypeModel.fromJson(Map<String, dynamic> json) => PlaceTypeModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
      );
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );
}
