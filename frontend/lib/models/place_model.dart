class PlaceModel {
  int? id;
  String? name;
  String? description;
  double? ratePoint;
  double? rateCount;
  String? address;
  String? cityName;
  String? districtName;
  String? placeTypeName;
  String? managerName;

  PlaceModel({
    this.id,
    this.name,
    this.description,
    this.ratePoint,
    this.rateCount,
    this.address,
    this.cityName,
    this.districtName,
    this.placeTypeName,
    this.managerName,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        ratePoint: json["ratePoint"],
        rateCount: json["rateCount"],
        address: json["address"],
        cityName: json["cityName"],
        districtName: json["districtName"],
        placeTypeName: json["placeTypeName"],
        managerName: json["managerName"],
      );
}
