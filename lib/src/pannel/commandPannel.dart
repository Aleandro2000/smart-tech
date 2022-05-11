import "package:flutter/material.dart";

class CommandPannel extends StatefulWidget {
  const CommandPannel({Key? key}) : super(key: key);

  @override
  State<CommandPannel> createState() => _CommandPannelState();
}

class _CommandPannelState extends State<CommandPannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Command Pannel"),
        centerTitle: true,
      ),
    );
  }
}
