import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        print('Google Sign-In canceled by user');
        return null;
      }

      // Step 3: Get Google authentication tokens
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Step 4: Create Firebase credential
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Step 5: Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error during Google Sign-In: $e');
      rethrow;
    }
  }

  googleSignOut() async {
    await _googleSignIn.signOut();
  }
}
