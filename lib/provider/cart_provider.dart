import 'dart:convert';
import 'package:cartapp/constants/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> _addCart = [];

  List<CartItem> get cartItems => _cartItems;
  List<CartItem> get addCart => _addCart;

  Future<void> fetchCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${baseUrl}api/cart/view.php'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String rawResponse = response.body.toString();
      String cleanedResponse = rawResponse.replaceFirst('Connected successfully', '');
      cleanedResponse = cleanedResponse.trim();



      final responseData = json.decode(cleanedResponse);

      _cartItems = (responseData['cart'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<String> addToCart(int productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('${baseUrl}api/cart/add.php'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      return 'Item added to cart successfully';
    } else {
      throw Exception('Failed to add item to cart');
    }
  }

  double get totalCartPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }
}
