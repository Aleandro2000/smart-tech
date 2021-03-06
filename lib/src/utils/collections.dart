import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/security.dart';

DatabaseReference _settingsRef = FirebaseDatabase.instance.ref("settings");

Future<bool> colorSettings(List<int> color) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (checkSession() && await checkConectivity()) {
      await _settingsRef
          .child('${user?.uid}')
          .child("color")
          .set(<String, Object>{
        "R": color[0],
        "G": color[1],
        "B": color[2],
      });
      return true;
    }
    return false;
  } catch (err) {
    return false;
  }
}
