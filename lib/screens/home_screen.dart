import 'package:flutter/material.dart';
import 'package:note_app/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        actions: [
          TextButton.icon(
            onPressed: () async{
              await AuthService().signOut();
            },
            icon: Icon(Icons.logout_outlined),
            label: Text('Logout'),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
