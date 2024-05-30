import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';

class TimeService {
  static Stream<String> getTime() async* {
    while (true) {
      try {
        var url = Uri.https(FoodLig.baseUrl, FoodLig.getTime);
        var response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        );

        if (response.statusCode == 200) {
          yield response.body;
        } else {
          yield 'Failed to get time';
        }
      } catch (e) {
        yield 'Error: ${e.toString()}';
      }
      await Future.delayed(const Duration(seconds: 15));
    }
  }
}
