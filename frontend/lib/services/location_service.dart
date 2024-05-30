import 'dart:io';

import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/location_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  static Future<LocationModel<City>> getAllCities() async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getAllCities);

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return LocationModel.fromJson(jsonResponse, City.fromJson);
      } else {
        throw Exception('Failed to get cities');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<LocationModel<District>> getDistrictByCityId(int cityId) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getDistrictByCityId,
        {'cityId': cityId.toString()});

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return LocationModel.fromJson(jsonResponse, District.fromJson);
      } else {
        throw Exception('Failed to get cities');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BaseLocationModel<City>> getCityById(int cityId) async {
    var url = Uri.https(
        FoodLig.baseUrl, FoodLig.getCityById, {'id': cityId.toString()});

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return BaseLocationModel.fromJson(jsonResponse, City.fromJson);
      } else {
        throw Exception('Konumunuz bulunamadı');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
