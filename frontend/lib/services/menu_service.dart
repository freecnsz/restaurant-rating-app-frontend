import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/menu_model.dart';
import 'package:restaurant_rating_frontend/shared_preferences/jwt_preferences.dart';

class MenuService {
  static Future<BaseMenuModel> getMenuByPlaceId(int placeId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getMenuByPlaceId,
        {'placeId': placeId.toString()});

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return BaseMenuModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get menu. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting menu: ${e.toString()}');
    }
  }

  static Future<bool> createMenu(
      String name, String description, int placeId, int menuTypeId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.createMenu);

    try {
      String token = "";
      await JwtPreferences.getToken().then((value) {
        token = value.toString();
      });

      // Make sure the token is not null or empty
      if (token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      var response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: convert.jsonEncode({
          'name': name,
          'description': description,
          'placeId': placeId,
          'menuTypeId': menuTypeId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create menu');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> deleteMenu(int menuId) async {
    var url = Uri.https(
        FoodLig.baseUrl, FoodLig.deleteMenu, {'id': menuId.toString()});

    try {
      String token = "";
      await JwtPreferences.getToken().then((value) {
        token = value.toString();
      });

      // Make sure the token is not null or empty
      if (token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      var response = await http.delete(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete menu');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
