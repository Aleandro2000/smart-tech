import 'package:firebase_auth/firebase_auth.dart';

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
      logoutAuth();
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
  } catch (err) {
    return false;
  }
}

Future<bool> loginAuth(String email, String password) async {
  try {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        await checkIfEmailInUse(email)) {
      logoutAuth();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        return true;
      } else if (user != null && !user.emailVerified) {
        FirebaseAuth.instance.signOut();
      }
      return false;
    }
    return false;
  } catch (err) {
    return false;
  }
}

void logoutAuth() {
  if (FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.signOut();
  }
}

Future<bool> changePasswordAuth(String oldPassword, String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;
    if (newPassword.isNotEmpty && user != null && email!.isNotEmpty) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return true;
    }
    return false;
  } catch (err) {
    return false;
  }
}

Future<bool> changeEmailAuth(String newEmail, String password) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;
    if (password.isNotEmpty &&
        user != null &&
        email!.isNotEmpty &&
        newEmail.isNotEmpty) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(credential);
      await user.updateEmail(newEmail);
      return true;
    }
    return true;
  } catch (err) {
    return false;
  }
}

Future<bool> deleteAuth(String password) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;
    if (password.isNotEmpty && user != null && email!.isNotEmpty) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(credential);
      await user.delete();
      return true;
    }
    return false;
  } catch (err) {
    return false;
  }
}

Future<bool> forgotPasswordAuth(String email) async {
  try {
    if (email.isNotEmpty && await checkIfEmailInUse(email)) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    }
    return false;
  } catch (err) {
    return false;
  }
}
