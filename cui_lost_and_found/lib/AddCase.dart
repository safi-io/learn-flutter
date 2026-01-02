import "package:flutter/material.dart";
import "models/case_model.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCaseScreen extends StatelessWidget {
  const AddCaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyForm();
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyForm createState() => _MyForm();
}

enum ProductStatus { lost, found }

class _MyForm extends State<MyForm> {
  final CollectionReference studentsRef = FirebaseFirestore.instance.collection(
    'products',
  );

  ProductStatus? _productStatus = ProductStatus.lost;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Validators
  String? _nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Product Name.';
    }
    if (value.toString().length < 4) {
      return "Enter a name length with at least 4.";
    }
    return null;
  }

  String? _detailsValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Product Details.';
    }
    if (value.toString().length < 4) {
      return "Enter a name length with at least 4.";
    }
    return null;
  }

  String? _phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Phone Number.';
    }
    if (value.toString().length < 11) {
      return "Phone Number must be at-least 11.";
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a Case Model
      final newCase = CaseModel(
        itemName: _nameController.text,
        itemDetails: _detailsController.text,
        contactNumber: _phoneController.text,
        status: _productStatus == ProductStatus.lost ? "lost" : "found",
        isResolved: "false",
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('products')
          .add(newCase.toMap());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Done.")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failure.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Case")),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Item Name
            TextFormField(
              decoration: InputDecoration(
                labelText: "Item Name",
                hintText: "Mobile Phone",
              ),
              controller: _nameController,
              validator: _nameValidator,
            ),

            SizedBox(height: 20),

            // Item Details
            TextFormField(
              decoration: InputDecoration(
                labelText: "Item Details",
                hintText: "Mobile Phone whose screen is broken.",
              ),
              controller: _detailsController,
              validator: _detailsValidator,
            ),

            SizedBox(height: 20),

            // Radio Buttons for Product Status
            ListTile(
              title: const Text('Lost'),
              leading: Radio<ProductStatus>(
                value: ProductStatus.lost,
                groupValue: _productStatus,
                onChanged: (ProductStatus? value) {
                  setState(() {
                    _productStatus = value;
                  });
                },
              ),
            ),

            ListTile(
              title: const Text('Found'),
              leading: Radio<ProductStatus>(
                value: ProductStatus.found,
                groupValue: _productStatus,
                onChanged: (ProductStatus? value) {
                  setState(() {
                    _productStatus = value;
                  });
                },
              ),
            ),

            SizedBox(height: 20),

            // Contact Number
            TextFormField(
              decoration: InputDecoration(
                labelText: "Contact Number",
                hintText: "0313-xxxxxxx",
              ),
              controller: _phoneController,
              validator: _phoneValidator,
            ),

            ElevatedButton(onPressed: _submitForm, child: Text("Add Case")),
          ],
        ),
      ),
    );
  }
}
