import 'package:restaurant_rating_frontend/models/user_model.dart';

class BaseModel<T> {
  bool? succeeded;
  String? message;
  dynamic errors;
  UserModel? user;

  BaseModel({
    this.succeeded,
    this.message,
    this.errors,
    this.user,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        user: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );
}
