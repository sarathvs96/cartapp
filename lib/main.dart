import 'package:cartapp/provider/auth_provider.dart';
import 'package:cartapp/provider/cart_provider.dart';
import 'package:cartapp/provider/product_provider.dart';
import 'package:cartapp/provider/register_provider.dart';
import 'package:cartapp/screens/cart_screen.dart';
import 'package:cartapp/screens/login.dart';
import 'package:cartapp/screens/product.dart';
import 'package:cartapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shopping Cart App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
        routes: {
          '/register': (context) => RegistrationScreen(),
          '/login': (context) => LoginPage(),
          '/home': (context) => ProductListPage(),
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}
