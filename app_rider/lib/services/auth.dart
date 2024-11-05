import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_rider/models/user.dart' as user_model;

class AuthResult {
  final String message;
  final bool isSuccess;

  AuthResult({required this.isSuccess, required this.message});
}

class AuthService {
  static bool isLoggedIn() {
    return (FirebaseAuth.instance.currentUser != null);
  }

  static user_model.User getUser() {
    User? fbUser = FirebaseAuth.instance.currentUser;

    return fbUser != null
        ? user_model.User.fromFirebaseUser(fbUser)
        : user_model.User();
  }

  static Future<AuthResult> createUserWithEmailAndPassword(
      user_model.User user, email, password) async {
    bool isSuccess = false;
    String message = '';

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // update uid
      User? fbUser = FirebaseAuth.instance.currentUser;
      user.uid = fbUser?.uid;
      user.email = fbUser?.email;

      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {}

    return AuthResult(isSuccess: isSuccess, message: message);
  }

  static Future<AuthResult> signInWithEmailAndPassword(
      user_model.User user, email, password) async {
    bool isSuccess = false;
    String? message = '';

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // update uid
      User? fbUser = FirebaseAuth.instance.currentUser;
      user.uid = fbUser?.uid;
      user.email = fbUser?.email;

      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid username or password. ';
      }
    } catch (e) {}

    return AuthResult(isSuccess: isSuccess, message: message);
  }

  static void deleteUser() {
    FirebaseAuth.instance.currentUser?.delete();
  }
}
