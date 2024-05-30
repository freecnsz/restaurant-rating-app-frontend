import 'package:restaurant_rating_frontend/models/place_model.dart';

class SinglePlaceModel {
  bool? succeeded;
  dynamic message;
  dynamic errors;
  PlaceModel? data;

  SinglePlaceModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory SinglePlaceModel.fromJson(Map<String, dynamic> json) =>
      SinglePlaceModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"] == null ? null : PlaceModel.fromJson(json["data"]),
      );
}
