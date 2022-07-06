import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/services/image_service.dart';
import 'package:note_app/utils/general_alert_dialog.dart';
import 'package:provider/provider.dart';

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
                  onPressed: () async {
                    // await ImageService().uploadImage('camera');
                    GeneralAlertDialog().customLoadingDialog(context);
                    await Provider.of<ImageService>(context, listen: false)
                        .uploadImage('camera');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image uploaded successfully!!!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: Icon(Icons.camera_outlined),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    // await ImageService().uploadImage('gallery');
                    GeneralAlertDialog().customLoadingDialog(context);
                    await Provider.of<ImageService>(context, listen: false)
                        .uploadImage('gallery');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image uploaded successfully!!!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: Icon(Icons.photo_outlined),
                  label: Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<ImageService>(context, listen: true)
                    .loadImages(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final image = snapshot.data[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: Container(
                                  height: 200,
                                  child: Image.network(
                                    image['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                GeneralAlertDialog()
                                    .customLoadingDialog(context);
                                await Provider.of<ImageService>(context,
                                        listen: false)
                                    .deleteImage(
                                  image['path'],
                                );
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Image deleted successfully!!!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_outlined),
                              color: Colors.red,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
