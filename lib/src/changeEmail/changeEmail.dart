import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
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
      FlushBarTemplate(context, "LINK SENT SUCCESSFULLY!",
          'A verification link has been sent to ${newEmail.text}', true);
    } else {
      FlushBarTemplate(
          context, "CHANGING EMAIL FAILED!", "Error to change email! :(", true);
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
                  child: SvgPicture.asset(
                    "assets/email.svg",
                    semanticsLabel: "Person who modify an email image",
                  ),
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
