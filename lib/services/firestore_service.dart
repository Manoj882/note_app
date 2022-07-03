import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final firestore = FirebaseFirestore.instance;

  Future addNote(String title, String description, String userId) async{
    try{
      final notes = await firestore.collection('notes').add({
        'title': title,
        'description': description,
        'date': DateTime.now(),
        'userId': userId,
      });
      return notes;

    } catch(e){
      print(e.toString());
    }

  }
}