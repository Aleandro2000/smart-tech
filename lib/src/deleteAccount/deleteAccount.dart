import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();

  void delete(BuildContext context) async {
    bool success = await deleteAuth(password.text);
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
        title: "DELETED ACCOUNT!",
        message: "Account deleted successfully! ;)",
        duration: const Duration(seconds: 3),
      ).show(context);
    } else {
      Flushbar(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.9),
        title: "DELETED ACCOUNT FAILED!",
        message: "Failed process for deleting account! :(",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Delete Account",
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
                    "assets/meditation.svg",
                    semanticsLabel: "Person who meditate ilustration",
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 25),
                  child: const Text(
                    "Are you sure you want to delete this account? This process is not reversible!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: password,
                    validator: (value) => requiredValidation(value!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your Password for Deleting',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      delete(context);
                    }
                  },
                  child: const Text("Yes, I want to delete this account!"),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.all(12.5),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 75),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                        "No, I don't want to continue this process!"),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.all(12.5),
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
