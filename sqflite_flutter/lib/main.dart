import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) return;

    final existingUser = await DBHelper.getUser(username);
    if (existingUser != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User already exists')));
      return;
    }

    User newUser = User(username: username, password: password);
    await DBHelper.insertUser(newUser);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('User registered')));
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    User? user = await DBHelper.getUser(username);
    if (user == null || user.password != password) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid credentials')));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Login successful')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login/Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: Text('Register')),
            ElevatedButton(onPressed: _login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
