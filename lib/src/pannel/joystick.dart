//TO DO

import "package:flutter/material.dart";
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

class Joystick extends StatefulWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(title: "Joystick"),
      body: JoystickArea(
        initialJoystickAlignment: Alignment.center,
        mode: JoystickMode.all,
        listener: (details) {},
      ),
    );
  }
}
