import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
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
        child: ListView(
          children: [
            Card(
              elevation: 5,
              color: Colors.teal,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                title: const Text(
                  'Learn Flutter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'You can learn dart and flutter from basic to complete job ready package in Udemy',
                  maxLines: 2,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditNoteScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
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
