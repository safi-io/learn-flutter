import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Flutter Form", home: MyForm());
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyForm createState() => _MyForm();
}

class _MyForm extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final RegExp _emailRegex = RegExp(
    r"^[A-Za-z0-9.%+-_]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$",
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Done.")));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Success(userEmail: _emailController.text),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Failure(userEmail: _emailController.text),
        ),
      );
    }
  }

  String? _nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    if (value.toString().length < 8) {
      return "Enter a name length with 8+.";
    }
    return null;
  }

  String? _emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Form")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'John Doe',
                ),
                validator: _nameValidator,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'john@doe.com',
                ),
                validator: _emailValidator,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit me."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Success extends StatelessWidget {
  final String userEmail;

  const Success({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Success")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Happy. Email: $userEmail"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go back"),
            ),
          ],
        ),
      ),
    );
  }
}

class Failure extends StatelessWidget {
  final String userEmail;

  const Failure({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Failure")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sad. Email: $userEmail"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go back"),
            ),
          ],
        ),
      ),
    );
  }
}
