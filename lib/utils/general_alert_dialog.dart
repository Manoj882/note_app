


import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/firestore_service.dart';

class GeneralAlertDialog {
  customLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20.0,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text('Loading'),
              ],
            ),
          );
        });
  }

  customAlertDialog(BuildContext context, String message, NoteModel model) {
    
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: Text(message),
            actions: [
              TextButton(
                
                onPressed: () async{
                  GeneralAlertDialog().customLoadingDialog(context);
                  await FirestoreService().deleteNote(model.id!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  
                },
                
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }
}
