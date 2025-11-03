import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // number of tabs
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Simple AppBar"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Home", icon: Icon(Icons.home)),
              Tab(text: "Chat", icon: Icon(Icons.chat)),
              Tab(text: "Profile", icon: Icon(Icons.person)),
            ],
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // removes top space
            children: [
              const DrawerHeader(
                child: Text(
                  "My Drawer Header",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text("Contact"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                },
              ),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            Center(child: Text("Home Screen")),
            Center(child: Text("Chat Screen")),
            Center(child: Text("Profile Screen")),
          ],
        ),


        
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Page")),
      body: const Center(child: Text("This is the About Page")),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Page")),
      body: const Center(child: Text("This is the Contact Page")),
    );
  }
}
