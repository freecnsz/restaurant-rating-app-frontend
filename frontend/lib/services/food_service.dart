import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/SingleFoodModel.dart';
import 'package:restaurant_rating_frontend/models/food_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/shared_preferences/jwt_preferences.dart';
import 'dart:convert' as convert;
import 'dart:io';

class FoodService {
  static Future<bool> createFood(
      FoodModel food, int foodTypeId, int menuId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.createFood);

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
          'name': food.name,
          'description': food.description,
          'price': food.price,
          'foodImage': food.foodImage,
          'foodTypeId': foodTypeId,
          'menuId': menuId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create food');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BaseFoodModel> getFoodByMenuId(int menuId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getFoodByParameter, {
      'MenuId': menuId.toString(),
    });

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return BaseFoodModel.fromJson(convert.jsonDecode(response.body));
      } else {
        throw Exception('Failed to get foods');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  static Future<SingleFoodModel> getFoodById(int foodId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getFoodById, {
      'id': foodId.toString(),
    });

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return SingleFoodModel.fromJson(convert.jsonDecode(response.body));
      } else {
        throw Exception("Ürün getirilirken bir hata oluştu.");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> deleteFood(int foodId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.deleteFood, {
      'id': foodId.toString(),
    });

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
        throw Exception('Failed to delete food');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> updateFood(int id, String name, String description,
      String foodImage, double price) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.updateFood, {
      'id': id.toString(),
    });

    try {
      // Retrieve token
      String token = "";
      await JwtPreferences.getToken().then((value) {
        token = value.toString();
      });

      // Make sure the token is not null or empty
      if (token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      var response = await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer $token', // Ensure 'Bearer' is included if required by API
        },
        body: convert.jsonEncode({
          'id': id,
          'name': name,
          'description': description,
          'foodImage': foodImage,
          'price': price,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update food');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
