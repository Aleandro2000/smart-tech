import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  void onSubmit(BuildContext context) async {
    if (newPassword.text == confirmPassword.text) {
      bool success =
          await changePasswordAuth(oldPassword.text, newPassword.text);

      if (success) {
        Navigator.pop(context);
        Flushbar(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.9),
          title: "PASSWORD CHANGED!",
          message: "Successfully changed password! ;)",
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        Flushbar(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.9),
          title: "CHANGING PASSWORD FAILED!",
          message: "Error to change password! :(",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } else {
      Flushbar(
        isDismissible: true,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        title: "CHANGING PASSWORD FAILED!",
        message: "Error to change password! :(",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Change Password",
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
                    "assets/security.svg",
                    semanticsLabel: "Security guard ilustration image",
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
                    controller: oldPassword,
                    validator: (value) => requiredValidation(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Old Password',
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
                    controller: newPassword,
                    validator: (value) => strongPasswordValidation(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'New Password',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 12.5),
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: confirmPassword,
                    validator: (value) => requiredValidation(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
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
