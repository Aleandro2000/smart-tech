import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

class VoiceCommands extends StatefulWidget {
  const VoiceCommands({Key? key}) : super(key: key);

  @override
  State<VoiceCommands> createState() => _VoiceCommandsState();
}

class _VoiceCommandsState extends State<VoiceCommands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Voice Commands",
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 12.5),
            child: const Text("TO DO!"),
          )
        ],
      ),
    );
  }
}
