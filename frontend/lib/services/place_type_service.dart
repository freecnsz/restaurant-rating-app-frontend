import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:restaurant_rating_frontend/models/place_type_model.dart';

class PlaceTypeService {
  static Future<List<Datum>> getAllPlaceTypes() async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.getAllPlaceTypes);

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return PlaceTypeModel.fromJson(jsonResponse).data!;
      } else {
        throw Exception('Failed to fetch place types');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
