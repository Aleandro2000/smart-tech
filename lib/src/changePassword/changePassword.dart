import "package:flutter/material.dart";
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  String newPassword = "";
  final confirmPassword = TextEditingController();

  void onSubmit(BuildContext context) async {
    if (newPassword == confirmPassword.text) {
      bool success = await changePasswordAuth(oldPassword.text, newPassword);
      if (success) {
        Navigator.pop(context);
        FlushBarTemplate(context, "PASSWORD CHANGED!",
            "Successfully changed password! ;)", true);
      } else {
        FlushBarTemplate(context, "CHANGING PASSWORD FAILED!",
            "Error to change password! :(", true);
      }
    } else {
      FlushBarTemplate(context, "CHANGING PASSWORD FAILED!",
          "Password and confirmation password must be the same! :(", true);
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
                    onChanged: (value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        newPassword = value!;
                      });
                    },
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
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: FlutterPasswordStrength(
                    password: newPassword,
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
