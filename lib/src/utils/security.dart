import 'package:flutter_security_checker/flutter_security_checker.dart';

bool check = false;

Future<bool> onCheckRealDevice(bool check) async {
  bool isRooted = await FlutterSecurityChecker.isRooted;
  bool isRealDevice = await FlutterSecurityChecker.isRealDevice;
  bool hasCorrectlyInstalled =
      await FlutterSecurityChecker.hasCorrectlyInstalled;

  return (isRooted && isRealDevice && hasCorrectlyInstalled) || !check;
}

Future<bool> isRealDevice() {
  return FlutterSecurityChecker.isRealDevice;
}
