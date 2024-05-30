import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/base_model.dart';
import 'package:restaurant_rating_frontend/models/user_model.dart';

// This class provides methods for authenticating user accounts
class AuthenticationService {
  // Authenticates a user with the provided email and password
  static Future<BaseModel<UserModel>> authenticate(
    String email,
    String password,
  ) async {
    var url = Uri.https(FoodLig.baseUrl,
        FoodLig.authenticatePlaceAdmin); // Updated to use the FoodLig class
    try {
      var response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: convert.jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return BaseModel<UserModel>.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to authenticate user');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> forgotPassword(String email) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.forgotPassword);
    try {
      var response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: convert.jsonEncode(<String, String>{
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
