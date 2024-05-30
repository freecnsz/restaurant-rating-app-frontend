import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/food_type_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class FoodTypeService {
  static Future<FoodTypeModel> getAllFoodTypes() async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getAllFoodTypes);

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return FoodTypeModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get food types');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
