import 'package:firebase_auth/firebase_auth.dart';
import 'package:hard_and_soft_mobile/src/utils/security.dart';

Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    if (await checkConectivity()) {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      if (list.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  } catch (err) {
    return false;
  }
}

Future<bool> registerAuth(String email, String password) async {
  try {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        !await checkIfEmailInUse(email) &&
        await checkConectivity()) {
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
        await checkIfEmailInUse(email) &&
        await checkConectivity()) {
      logoutAuth();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => null);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        return true;
      } else if (user != null && !user.emailVerified) {
        logoutAuth();
      }
      return false;
    }
    return false;
  } on FirebaseAuthException catch (e) {
    if (e.code.isNotEmpty) {
      return false;
    }
    return true;
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
    if (newPassword.isNotEmpty &&
        user != null &&
        email!.isNotEmpty &&
        await checkConectivity()) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);
      await user.reauthenticateWithCredential(credential).then((value) => null);

      user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        return true;
      }
      return false;
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
        newEmail.isNotEmpty &&
        !await checkIfEmailInUse(newEmail) &&
        await checkConectivity()) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential).then((value) => null);

      user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.verifyBeforeUpdateEmail(newEmail);
        logoutAuth();
        return true;
      }
      return false;
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
    if (password.isNotEmpty &&
        user != null &&
        email!.isNotEmpty &&
        await checkConectivity()) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential).then((value) => null);

      user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
        logoutAuth();
        return true;
      }
      return false;
    }
    return false;
  } catch (err) {
    return false;
  }
}

Future<bool> forgotPasswordAuth(String email) async {
  try {
    if (email.isNotEmpty &&
        await checkIfEmailInUse(email) &&
        await checkConectivity()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    }
    return false;
  } catch (err) {
    return false;
  }
}

bool checkSession() {
  return FirebaseAuth.instance.currentUser != null;
}

String? getEmailCurrentUser() {
  return FirebaseAuth.instance.currentUser?.email;
}
