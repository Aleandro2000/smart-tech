//TO DO

import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class CommandPannel extends StatefulWidget {
  const CommandPannel({Key? key}) : super(key: key);

  @override
  State<CommandPannel> createState() => _CommandPannelState();
}

class _CommandPannelState extends State<CommandPannel> {
  final _formKey = GlobalKey<FormState>();
  final input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Command Pannel",
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(50, 50, 50, 12.5),
                child: TextFormField(
                  controller: input,
                  validator: (value) => requiredValidation(value!),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
