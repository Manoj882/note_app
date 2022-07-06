import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/authentication/login_screen.dart';
import 'package:note_app/screens/authentication/register_screen.dart';

import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/image_section/upload_image_screen.dart';
import 'package:note_app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      // home:  RegisterScreen(),
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // return HomeScreen(user: snapshot.data);
            return UploadImageScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
