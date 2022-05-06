import "package:flutter/material.dart";
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
      title: const Text("Smart Tech"),
      image: Image.asset("assets/chip.png"),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: const TextStyle(),
      photoSize: 100.0,
      useLoader: false,
    );
  }
}
