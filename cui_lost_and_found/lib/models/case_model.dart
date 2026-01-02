// import 'package:cloud_firestore/cloud_firestore.dart';

class CaseModel {
  final String? id;
  final String itemName;
  final String itemDetails;
  final String contactNumber;
  final String status;
  final String isResolved;
  final DateTime createdAt;

  CaseModel({
    this.id,
    required this.itemName,
    required this.itemDetails,
    required this.contactNumber,
    required this.status,
    required this.isResolved,
    required this.createdAt,
  });

  // Convert a Dart Object into a Map to send to Firebase
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'itemDetails': itemDetails,
      'contactNumber': contactNumber,
      'status': status,
      'isResolved': isResolved,
      'createdAt': createdAt,
    };
  }

}
