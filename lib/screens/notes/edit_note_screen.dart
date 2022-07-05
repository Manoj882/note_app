import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/services/firestore_service.dart';
import 'package:note_app/utils/general_alert_dialog.dart';

import '../../models/note_model.dart';

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({required this.note, required this.user, Key? key})
      : super(key: key);

  final NoteModel note;
  final User user;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //retrieve data to show in update page
    titleController.text = note.title!;
    descriptionController.text = note.description!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await GeneralAlertDialog().customAlertDialog(
                context,
                'Are you sure want to remove the note?',
                note,
              );
            },
            icon: const Icon(
              Icons.delete_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    GeneralAlertDialog().customLoadingDialog(context);
                    if (titleController.text == '' ||
                        descriptionController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'All fields are required!!!',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      await FirestoreService().updateNote(
                        note.id!,
                        titleController.text,
                        descriptionController.text,
                      );

                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(
                            user: user,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Update Note'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
