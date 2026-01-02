import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final CollectionReference studentsRef = FirebaseFirestore.instance.collection(
    'students',
  );

  bool containsOnlyNumericDigits(String str) {
    final RegExp digitOnlyRegExp = RegExp(r'^\d+$');
    return digitOnlyRegExp.hasMatch(str);
  }

  bool isEmailValid(String email) {
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    return emailValid;
  }

  /// ADD STUDENT
  Future<void> addStudent() async {
    await studentsRef.add({
      'id': idController.text.trim(),
      'name': nameController.text.trim(),
      'mail': mailController.text.trim(),
      'address': addressController.text.trim(),
    });

    clearControllers();
    Navigator.pop(context);
  }

  /// UPDATE STUDENT
  Future<void> updateStudent(String docId) async {
    await studentsRef.doc(docId).update({
      'id': idController.text.trim(),
      'name': nameController.text.trim(),
      'mail': mailController.text.trim(),
      'address': addressController.text.trim(),
    });

    clearControllers();
    Navigator.pop(context);
  }

  /// DELETE STUDENT
  Future<void> deleteStudent(String docId) async {
    await studentsRef.doc(docId).delete();
  }

  void clearControllers() {
    idController.clear();
    nameController.clear();
    mailController.clear();
    addressController.clear();
  }

  /// ADD DIALOG
  void openAddStudentDialog() {
    showDialog(
      context: context,
      builder: (_) => studentDialog(title: "Add Student", onSave: addStudent),
    );
  }

  /// EDIT DIALOG
  void openEditStudentDialog(DocumentSnapshot student) {
    idController.text = student['id'];
    nameController.text = student['name'];
    mailController.text = student['mail'];
    addressController.text = student['address'];

    showDialog(
      context: context,
      builder: (_) => studentDialog(
        title: "Edit Student",
        onSave: () => updateStudent(student.id),
      ),
    );
  }

  /// STUDENT FORM DIALOG
  Widget studentDialog({required String title, required VoidCallback onSave}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: "ID",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "ID is required";
                  }
                  if (!containsOnlyNumericDigits(value.trim())) {
                    return "ID must be an integer";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: mailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  if (!isEmailValid(value.trim())) {
                    return "Email is not properly formatted";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            clearControllers();
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              onSave();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddStudentDialog,
        child: const Icon(Icons.add),
      ),

      /// READ STUDENTS (REAL-TIME)
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No students added"));
          }

          final students = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    "${student['id']} • ${student['name']}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Email: ${student['mail']}\nAddress: ${student['address']}",
                    ),
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => openEditStudentDialog(student),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteStudent(student.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
