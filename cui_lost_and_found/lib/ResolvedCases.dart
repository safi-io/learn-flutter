import 'package:flutter/material.dart';

class ResolvedCaseListScreen extends StatelessWidget {
  const ResolvedCaseListScreen({super.key});

  // This mimics what you will eventually get from Firebase
  final List<Map<String, dynamic>> staticCases = const [
    {
      "itemName": "iPhone 13",
      "itemDetails": "Blue color with a cracked screen protector.",
      "contactNumber": "0300-1234567",
      "status": "lost",
      "isResolved": "false",
      "createdAt": "2026-01-01T10:30:00Z",
    },
    {
      "itemName": "Student ID Card",
      "itemDetails": "Found near the CUI Library entrance.",
      "contactNumber": "0311-9876543",
      "status": "found",
      "isResolved": "true",
      "createdAt": "2026-01-01T11:15:00Z",
    },
    {
      "itemName": "Laptop Charger",
      "itemDetails": "Dell 65W charger found in CS Lab 2.",
      "contactNumber": "0322-1122334",
      "status": "found",
      "isResolved": "false",
      "createdAt": "2026-01-01T09:00:00Z",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeList = staticCases
        .where((item) => item['isResolved'] == "true")
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("All Resolved Cases")),

      body: ListView.builder(
        itemCount: activeList.length,
        itemBuilder: (context, index) {
          final item = activeList[index];
          final isLost = item['status'] == 'lost';

          return Card(
            elevation: 3,
            child: ListTile(
              title: Text(
                item['itemName'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['itemDetails'], maxLines: 2),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['status'].toString().toUpperCase(),
                    style: TextStyle(
                      color: isLost ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
              onTap: () {
                // You can add a detailed view later
                print("Tapped on ${item['itemName']}");
              },
            ),
          );
        },
      ),
    );
  }
}
