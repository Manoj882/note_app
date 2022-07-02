import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future<User?> register(
      BuildContext context, String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final authUser = userCredential.user;
      return authUser;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<User?> login(
      BuildContext context, String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final authUser = userCredential.user;
      return authUser;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch(e){
      debugPrint(e.toString());
    }
  }

  //For Google Sign In
  Future<User?> signInWithGoogle() async{
    try{
      //trigger the authentication dialog
      final googleSignInAccount = await GoogleSignIn().signIn();

      if(googleSignInAccount != null){
        //obtain the authentication details from the rquest
        final googleSingInAuthentication = await googleSignInAccount.authentication;
        //create a new credential
        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleSingInAuthentication.accessToken,
          idToken: googleSingInAuthentication.idToken
        );

        //Once signed in return  the user data from firebase
        final userCredential = await firebaseAuth.signInWithCredential(authCredential);
        return userCredential.user;
      }


    } catch(e){
      debugPrint(e.toString());
    }
  }

  //For logout
  Future signOut() async{
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();

  }
}
