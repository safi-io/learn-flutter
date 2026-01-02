import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Users Demo',
      home: UsersPage(),
    );
  }
}

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final response = await ApiService.getUsers();
      setState(() {
        users = response;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching users: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dummy Users')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user['id'].toString())),
            title: Text(user['name']),
            subtitle: Text(user['email']),
          );
        },
      ),
    );
  }
}
