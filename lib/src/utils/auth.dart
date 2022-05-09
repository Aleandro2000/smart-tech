import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    final list =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

    if (list.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return true;
  }
}

Future<bool> registerAuth(String email, String password) async {
  try {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        !await checkIfEmailInUse(email)) {
      User? user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        user.sendEmailVerification();
        return true;
      }
      return false;
    }
    return false;
  } on PlatformException {
    return false;
  } catch (err) {
    return false;
  }
}

Future<bool> loginAuth(String email, String password) async {
  try {
    if (email.isNotEmpty && password.isNotEmpty) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      return user != null;
    }
    return false;
  } catch (err) {
    return false;
  }
}

User? getSession(bool debugLog) {
  if (debugLog) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  return FirebaseAuth.instance.currentUser;
}

void logoutAuth() async {
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.signOut();
  }
}
