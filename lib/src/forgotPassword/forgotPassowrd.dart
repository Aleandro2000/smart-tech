import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  void onSubmit(BuildContext context) async {
    bool success = await forgotPasswordAuth(email.text);
    if (success) {
      Navigator.pop(context);
      Flushbar(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColors.flusBarItemColor,
        title: "RECOVER ACCOUNT!",
        message: 'A recover link has been sent to ${email.text}',
        duration: const Duration(seconds: 3),
      ).show(context);
    } else {
      Flushbar(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColors.flusBarItemColor,
        title: "PROBLEM FORE RECOVERING!",
        message: "Something is wrong! :(",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Forgot Password",
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
                    "assets/forgot.svg",
                    semanticsLabel: "Person who forgot a password image",
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 6.25),
                  child: TextFormField(
                    controller: email,
                    validator: (value) => emailValidator(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address',
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
