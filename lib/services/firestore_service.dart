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

  Future updateNote(String docId, String title, String description) async{
    
    try{
      await firestore.collection('notes').doc(docId).update({
        'title': title,
        'description': description,
      });

     
    } catch(e){
      print(e.toString());
    }
  }
}