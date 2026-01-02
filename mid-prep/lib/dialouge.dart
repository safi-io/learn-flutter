import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Simple Dialog"),
          content: const Text("This is a basic Flutter dialog."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Dialog Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSimpleDialog(context),
          child: const Text("Show Dialog"),
        ),
      ),
    );
  }
}
