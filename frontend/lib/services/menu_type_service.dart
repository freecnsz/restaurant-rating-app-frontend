import 'dart:io';
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/menu_type_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MenuTypeService {
  static Future<BaseMenuTypeModel> getAllMenuTypes() async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getAllMenuTypes);

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return BaseMenuTypeModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get menu types. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting menu types: ${e.toString()}');
    }
  }
}
