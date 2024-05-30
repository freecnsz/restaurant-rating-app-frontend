import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/base_place_model.dart';
import 'package:restaurant_rating_frontend/models/single_place_model.dart';
import 'package:restaurant_rating_frontend/shared_preferences/jwt_preferences.dart';

class PlaceService {
  static Future<BasePlaceModel> getPlaceByCityId(int cityId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getPlaceByCityId,
        {'CityId': cityId.toString()});

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return BasePlaceModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get places by city ID. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting places by city ID: ${e.toString()}');
    }
  }

  static Future<SinglePlaceModel> getPlaceById(int placeId) async {
    var url = Uri.https(
        FoodLig.baseUrl, FoodLig.getPlaceById, {'id': placeId.toString()});

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return SinglePlaceModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get place by ID. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting place by ID: ${e.toString()}');
    }
  }

  static Future<bool> updatePlace(
      int id, String name, String description) async {
    var url =
        Uri.https(FoodLig.baseUrl, FoodLig.updatePlace, {'id': id.toString()});

    try {
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
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: convert.jsonEncode({
          'id': id,
          'name': name,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to update place. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating place: ${e.toString()}');
    }
  }
}
