import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_rating_frontend/constants/foodlig.dart';

class ResetPasswordService {
  static Future<bool> resetPasswordForget(String email, String token,
      String password, String confirmPassword) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.resetPassword);

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: convert.jsonEncode(<String, String>{
          'email': email,
          'token': token,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Şifre sıfırlama başarısız oldu: $e');
    }
  }

  static Future<bool> resetPassword(
      String id, String oldPassword, String newPassword) async {
    var url = Uri.https(FoodLig.baseUrl, FoodLig.resetPassword);

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: convert.jsonEncode(<String, String>{
          'userId': id,
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Şifre güncelleme başarısız oldu: $e');
    }
  }
}
