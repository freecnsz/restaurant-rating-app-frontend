class BaseLocationModel<T> {
  bool? succeeded;
  dynamic message;
  dynamic errors;
  T? data;

  BaseLocationModel({
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory BaseLocationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) =>
      BaseLocationModel(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: fromJsonT(json["data"]),
      );
}

class LocationModel<T> {
  int? pageNumber;
  int? pageSize;
  bool? succeeded;
  dynamic message;
  dynamic errors;
  List<T>? data;

  LocationModel({
    this.pageNumber,
    this.pageSize,
    this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory LocationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) =>
      LocationModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"],
        data: List<T>.from(json["data"].map((x) => fromJsonT(x))),
      );
}

class City {
  int? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );
}

class District {
  int? id;
  String? name;
  String? cityName;

  District({
    this.id,
    this.name,
    this.cityName,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        cityName: json["cityName"],
      );
}
