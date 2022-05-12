import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  final newEmail = TextEditingController();
  final password = TextEditingController();

  void onSubmit(BuildContext context) async {
    bool success = await changeEmailAuth(newEmail.text.trim(), password.text);
    if (success) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
      Flushbar(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.9),
        title: "LINK SENT SUCCESSFULLY!",
        message: 'A verification link has been sent to ${newEmail.text}',
        duration: const Duration(seconds: 3),
      ).show(context);
    } else {
      Flushbar(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.9),
        title: "CHANGING EMAIL FAILED!",
        message: "Error to change email! :(",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Change Email",
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Image(image: AssetImage('assets/logo.png')),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 6.25),
                  child: TextFormField(
                    controller: newEmail,
                    validator: (value) => emailValidator(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'New Email Address',
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 6.25),
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: password,
                    validator: (value) => requiredValidation(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSubmit(context);
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
