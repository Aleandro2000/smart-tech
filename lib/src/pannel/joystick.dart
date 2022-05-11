import "package:flutter/material.dart";

class Joystick extends StatefulWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joystick"),
        centerTitle: true,
      ),
    );
  }
}
