import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final firestore = FirebaseFirestore.instance;

  Future addNote(String title, String description, String image, String userId) async{
    try{
      final notes = await firestore.collection('notes').add({
        'title': title,
        'description': description,
        'image': image,
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
      final updateNote = await firestore.collection('notes').doc(docId).update({
        'title': title,
        'description': description,
      });
      return updateNote;
    } catch(e){
      print(e.toString());
    }
  }

  Future deleteNote(String docId) async{
    try{
      final deleteNote = await firestore.collection('notes').doc(docId).delete();
      return deleteNote;

    } catch(e){
      print(e.toString());
    }
  }
}