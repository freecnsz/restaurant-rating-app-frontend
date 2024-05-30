import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:http/http.dart' as http;

class ConfirmEmailService {
  static Future<bool> confirmEmail(String userId, String code) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.confirmEmail,
        {'userId': userId, 'code': code});

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to confirm email');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
