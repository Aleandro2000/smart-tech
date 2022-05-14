// ignore_for_file: import_of_legacy_library_into_null_safe, file_names

import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';
import "package:splashscreen/splashscreen.dart";
import "package:hard_and_soft_mobile/src/login/login.dart";

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: const Login(),
      loadingText: const Text(''),
      image: Image.asset("assets/chip.png"),
      backgroundColor: ThemeColors.splashScreenTheme,
      photoSize: 109.0,
      useLoader: false,
    );
  }
}
