import 'dart:convert';
import 'package:cartapp/constants/base_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = '${baseUrl}api/products/list.php';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        String rawResponse = response.body.toString();
        String cleanedResponse = rawResponse.replaceFirst('Connected successfully', '');
        cleanedResponse = cleanedResponse.trim();

        final responseData = json.decode(cleanedResponse);
        _products = (responseData['products'] as List)
            .map((data) => Product.fromJson(data))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw error;
    }
  }
}
