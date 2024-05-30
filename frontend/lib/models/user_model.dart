class UserModel {
  String? id;
  String? userName;
  String? email;
  List<String>? roles;
  bool? isVerified;
  String? jwToken;
  int? placeId;
  int? cityId;
  int? districtId;

  UserModel({
    this.id,
    this.userName,
    this.email,
    this.roles,
    this.isVerified,
    this.jwToken,
    this.placeId,
    this.cityId,
    this.districtId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        isVerified: json["isVerified"],
        jwToken: json["jwToken"],
        placeId: json["placeId"],
        cityId: json["cityId"],
        districtId: json["districtId"],
      );
}
