import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/base_url.dart';

class RegistrationProvider with ChangeNotifier {
  String? _username;
  String? _email;
  String? _password;

  String? get username => _username;
  String? get email => _email;
  String? get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> register() async {
    final url = '${baseUrl}api/auth/register.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': _username,
          'email': _email,
          'password': _password,
        }),
      );

      if (response.statusCode == 201) {
        print('Registration successful: ${response.body}');
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }
}
