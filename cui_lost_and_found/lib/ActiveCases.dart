import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveCaseListScreen extends StatelessWidget {
  const ActiveCaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Active Cases")),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('isResolved', isEqualTo: "false")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final activeList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: activeList.length,
            itemBuilder: (context, index) {
              final item = activeList[index].data() as Map<String, dynamic>;
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
                    print("Tapped on ${item['itemName']}");
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
