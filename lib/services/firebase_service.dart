import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  /// Adds a machine document to the 'machines' collection and returns the
  /// created DocumentReference.
  static Future<DocumentReference<Map<String, dynamic>>> addMachine(
      Map<String, dynamic> data) async {
    // Basic validation example (adjust required fields as needed)
    if (data['name'] == null || data['name'].toString().isEmpty) {
      throw ArgumentError('Machine "name" is required');
    }

    try {
      final ref = await FirebaseFirestore.instance.collection('machines').add(data);
      return ref;
    } catch (e, st) {
      // You may want to log the error to analytics or rethrow a nicer error
      // For now, rethrow to preserve the stack trace for callers to handle.
      rethrow;
    }
  }

  /// Alternative: create a document with a client-generated id and return it.
  static Future<DocumentReference<Map<String, dynamic>>> createMachineWithId(
      Map<String, dynamic> data) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('machines').doc();
      await docRef.set(data);
      return docRef;
    } catch (e) {
      rethrow;
    }
  }
}
