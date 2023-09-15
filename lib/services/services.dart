import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference cricketDataCollection =
  FirebaseFirestore.instance.collection('cricket_customise_score');

  Future<void> addData(Map<String, dynamic> data) async {
    try {
      await cricketDataCollection.add(data);
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<void> updateFirestoreData(Map<String, dynamic> updatedData,
      String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cricket_customise_score')
          .doc(documentId) // Use the provided document ID
          .update(updatedData);
    } catch (error) {
      print('Error updating Firestore data: $error');
    }
  }
}