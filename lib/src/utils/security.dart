import 'package:flutter_security_checker/flutter_security_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

Future<bool> checkConectivity() async {
  ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}
