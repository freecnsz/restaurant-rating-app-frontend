import 'package:restaurant_rating_frontend/constants/foodlig.dart';
import 'package:http/http.dart' as http;

class DeleteUserService {
  static deleteUser(String id) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.deleteUser, {'userId': id});

    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Kullanıcı silme başarısız oldu: $e');
    }
  }
}
