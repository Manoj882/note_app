import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String? title;
  String? description;
  Timestamp? date;
  String? userId;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
  });

  // factory NoteModel.fromJson(DocumentSnapshot snapshot) {

  //   return NoteModel(
  //     id: snapshot.id.toString(),
  //     title: snapshot['title'],
  //     description: snapshot['description'],
  //     date: snapshot['data'],
  //     userId: snapshot['userId'],
  //   );
  // }

  NoteModel.fromJson(Map<String, dynamic> json, this.id) {
    
    title = json['title'];
    description = json['description'];
    date = json['date'];
    userId = json['userId'];
  }

 

  // NoteModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
  //   id = snapshot['id'];
  //   title = snapshot['title'];
  //   description = snapshot['description'];
  //   date = snapshot['date'];
  //   userId = snapshot['userId'];
  // }
}
