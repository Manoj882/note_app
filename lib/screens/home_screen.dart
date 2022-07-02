import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final firestore = FirebaseFirestore.instance;

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final users = await firestore.collection('users');

                //Here, add method create auto document id
                // await users.add({
                //   'name': 'manoj'
                // });

                //Here, doc is used to give own document id
                await users.doc('google123').set({
                  'name': 'Google',
                });
              },
              child: const Text(
                'Add data to Firestore',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final users = firestore.collection('users');
                //for fetching all data
                // final allResults = await users.get();
                // allResults.docs.forEach((result) {
                //   print(result.data());
                // });

                //for fetching particular data -> give document id in doc()
                final result = await users.doc('google123').get();
                print(result.data());

                //  //For stream data
                // users.doc('google123').snapshots().listen((result) {
                //   print(result.data());
                // },
                // );
              },
              child: const Text('Read data from Firestore'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await firestore.collection('users').doc('google123').update({
                  'name': 'Google Flutter',
                });
              },
              child: const Text('Update data in Firestore'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async{
                await firestore.collection('users').doc('google123').delete();
              },
              child: const Text('Delete data from Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}
