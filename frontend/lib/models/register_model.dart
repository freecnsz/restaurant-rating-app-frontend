class RegisterModel {
  bool? succeeded;
  String? message;
  dynamic errors;
  String? data;

  RegisterModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"],
      );
}
