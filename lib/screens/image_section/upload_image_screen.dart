import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/services/image_service.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload to Firebase Storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: basePadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async{
                    await ImageService().uploadImage('camera');
                  },
                  icon: Icon(Icons.camera_outlined),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () async{
                    await ImageService().uploadImage('gallery');
                  },
                  icon: Icon(Icons.photo_outlined),
                  label: Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
