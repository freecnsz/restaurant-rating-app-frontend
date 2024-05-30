import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/register_model.dart';

// This service class is responsible for register a user
class RegisterService {
  // This method sends a POST request to the server to register a user
  static Future<RegisterModel> register(
    String firstName,
    String lastName,
    String email,
    String userName,
    String password,
    String confirmPassword,
    String placeName,
    String? placeDescription,
    String placeAddress,
    int placeCity,
    int placeDistrict,
    int placeTypeId,
  ) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.registerPlaceAdmin);
    try {
      var response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: convert.jsonEncode(<String, dynamic>{
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "userName": userName,
          "password": password,
          "confirmPassword": confirmPassword,
          "placeName": placeName,
          "placeDescription": placeDescription,
          "placeAddress": placeAddress,
          "placeCityId": placeCity,
          "placeDistrictId": placeDistrict,
          "placeTypeId": placeTypeId,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return RegisterModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
