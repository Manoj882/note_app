import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:image_picker/image_picker.dart';

class ImageService extends ChangeNotifier {
  final firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadImage(String inputSource) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source:
          inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedImage == null) {
      return null;
    } else {
      final fileName = pickedImage.name;
      final imageFile = File(pickedImage.path);
      final compressedFile = await FlutterNativeImage.compressImage(imageFile.path, quality: 50);

      // print('Original Size:');
      // print(imageFile.lengthSync());
      // print('Compressed Size:');
      // print(compressedFile.lengthSync());

      try {
        await firebaseStorage.ref(fileName).putFile(compressedFile);
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List> loadImages() async {
    List<Map> files = [];
    final result = await firebaseStorage.ref().list();
    final allFiles = result.items;
 
    await Future.forEach(
      allFiles,
      (Reference file) async {
        final String fileUrl = await file.getDownloadURL();
        files.add({'url': fileUrl, 'path': file.fullPath});
      },
    );
    return files;
  }

  Future<void> deleteImage(String ref) async {
    final deleteImage = await firebaseStorage.ref(ref).delete();
    notifyListeners();
    return deleteImage;
  }
}
