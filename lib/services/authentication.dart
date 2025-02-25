import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //for storing data in cloud stroage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> singUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        //for register  user in firebase auth with email and password to our cloud storage
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //for adding user to our cloud storage
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });
        res = "success";
      }

      //for adding
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  //for login
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the field';
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  //signout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

//for signup
