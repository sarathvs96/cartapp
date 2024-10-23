import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                final success = await authProvider.login(username, password);
                if (!success) {
                  setState(() {
                    _errorMessage = "Login failed. Please check your credentials.";
                  });
                } else {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              child: const Text("Login"),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/register');
                },
                child: const Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
