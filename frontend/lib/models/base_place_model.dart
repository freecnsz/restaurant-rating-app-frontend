import 'package:restaurant_rating_frontend/models/place_model.dart';

class BasePlaceModel {
  int? pageNumber;
  int? pageSize;
  bool? succeeded;
  String? message;
  String? errors;
  List<PlaceModel>? data;

  BasePlaceModel({
    this.pageNumber,
    this.pageSize,
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory BasePlaceModel.fromJson(Map<String?, dynamic> json) {
    return BasePlaceModel(
      pageNumber: json["pageNumber"] as int?,
      pageSize: json["pageSize"] as int?,
      succeeded: json["succeeded"] as bool?,
      message: json["message"] as String?,
      errors: json["errors"] as String?,
      data: json["data"] == null
          ? null // Set data to null if it's null in the JSON
          : (json["data"] as List<dynamic>)
              .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
