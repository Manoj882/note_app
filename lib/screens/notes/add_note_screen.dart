import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/notes/edit_note_screen.dart';
import 'package:note_app/services/firestore_service.dart';
import 'package:note_app/utils/general_alert_dialog.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({required this.user, Key? key}) : super(key: key);
  final User user;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  File? imageFile;
  String? fileName;

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return null;
    } else {
      fileName = pickedImage.name;
      imageFile = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: ()async{
                  await uploadImage();

                },
                child: Container(
                  height: 150,
                  child: imageFile == null
                      ? Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 100,
                          ),
                        )
                      : Center(
                          child: Image.file(imageFile!),
                        ),
                ),
              ),
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
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    GeneralAlertDialog().customLoadingDialog(context);
                    if (titleController.text == '' ||
                        descriptionController.text == '' || imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'All fields are required',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      String imageUrl = await FirebaseStorage.instance.ref(fileName).putFile(imageFile!).then((result) {
                        return result.ref.getDownloadURL();
                      });

                      await FirestoreService().addNote(titleController.text,
                          descriptionController.text,imageUrl, user.uid);

                      Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(user: user),
                      ),
                    );
                    }
                    
                  },
                  child: Text('Add Note'),
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
