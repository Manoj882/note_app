import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/notes/add_note_screen.dart';
import 'package:note_app/screens/notes/edit_note_screen.dart';
import 'package:note_app/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.user, Key? key}) : super(key: key);

  final firestore = FirebaseFirestore.instance;
  
  final User user;
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Logout'),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: basePadding,
        child: StreamBuilder(
          stream: firestore.collection('notes').where('userId', isEqualTo: user.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
       
            if(snapshot.hasData){
              if(snapshot.data!.docs.isNotEmpty){
                return ListView.builder(
                  
                  itemCount: snapshot.data!.docs.length,
                
                  itemBuilder: (context, index){
                    // final data = snapshot.data!.docs[index].data();
  
                    // NoteModel note = NoteModel.fromJson(data);


                    final data = snapshot.data!.docs[index].data();
                    final id = snapshot.data!.docs[index].id;
                    final note = NoteModel.fromJson(data, id);
                   
                    
                    return Card(
                      elevation: 5,
                      color: Colors.teal,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        title: Text(
                          note.title!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          note.description!,
                          maxLines: 10,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditNoteScreen(note: note,user: user,),
                            ),
                          );
                      
                        },
                      ),
                    );
                  },
                  
                  );
                  




              } else{
                return const Center(
                  child: Text('No Notes Available'),
                );
              }
             

            } else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>  AddNoteScreen(user: user,),
            ),
          );
        },
        backgroundColor: Colors.orangeAccent,
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
      );
      
    
    
  }
}
