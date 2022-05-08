import 'package:firebase_auth/firebase_auth.dart';

void registerAuth(String email, String password) async {
  if (email.isNotEmpty && password.isNotEmpty) {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}

Future<bool> loginAuth(String email, String password) async {
  if (email.isNotEmpty && password.isNotEmpty) {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
  return false;
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

void logoutAuth() {
  FirebaseAuth.instance.signOut();
}
