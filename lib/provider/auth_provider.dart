import 'dart:convert';
import 'package:cartapp/constants/base_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<bool> login(String username, String password) async {
    final url = '${baseUrl}api/auth/login.php';
    print(username);
    print(password);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body:json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        _token = response.body.toString().split('"token":')[1].replaceAll('"', '').replaceAll('}', '');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
