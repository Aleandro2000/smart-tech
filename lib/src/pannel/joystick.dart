//TO DO

import "package:flutter/material.dart";
import 'package:flutter_joystick/flutter_joystick.dart';

class Joystick extends StatefulWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  final JoystickMode _joystickMode = JoystickMode.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joystick"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: JoystickArea(
          mode: _joystickMode,
          listener: (details) {},
        ),
      ),
    );
  }
}
