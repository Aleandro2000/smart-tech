import "package:flutter/material.dart";

class VoiceCommands extends StatefulWidget {
  const VoiceCommands({Key? key}) : super(key: key);

  @override
  State<VoiceCommands> createState() => _VoiceCommandsState();
}

class _VoiceCommandsState extends State<VoiceCommands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Commands"),
        centerTitle: true,
      ),
    );
  }
}
