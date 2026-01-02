import 'package:flutter/material.dart';
import 'AddCase.dart';
import 'ActiveCases.dart';
import 'ResolvedCases.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WELCOME BACK SAFI, CUI LOST & FOUND"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Click on the below buttons to go to desired menu."),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ActiveCaseListScreen(),
                      ),
                    );
                  },
                  child: const Text("Active Cases"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResolvedCaseListScreen(),
                      ),
                    );
                  },
                  child: const Text("Resolved Cases"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCaseScreen(),
            ),
          );
        },
        label: const Text("Add Case"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
