import "package:flutter/material.dart";
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:hard_and_soft_mobile/src/legal/terms_of_use.dart';
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/validators.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool termsOfUse = false;

  final email = TextEditingController();
  String password = "";
  final confirmPassword = TextEditingController();

  void check() {
    setState(() {
      termsOfUse = !termsOfUse;
    });
  }

  void register(BuildContext context) async {
    if (password == confirmPassword.text) {
      bool success = await registerAuth(email.text.trim(), password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
        FlushBarTemplate(
            context,
            "REGISTER SUCCESSFULLY!",
            'A email verification link has been sent to ${email.text.trim()}',
            false);
      } else {
        FlushBarTemplate(
            context, "REGISTER FAILED!", "Error to register user! :(", false);
      }
    } else {
      FlushBarTemplate(context, "REGISTER FAILED!",
          "Password and confirmation password has to be the same! :(", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    semanticLabel: "Smart Tech Logo",
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 6.25),
                  child: TextFormField(
                    validator: (value) => emailValidator(value!),
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
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
                    validator: (value) => strongPasswordValidation(value!),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
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
                    validator: (value) => requiredValidation(value!),
                    controller: confirmPassword,
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
                    password: password,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: termsOfUse,
                            onChanged: (context) => check(),
                          ),
                          const Text(
                            "I accept Terms of Use.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Terms()),
                              );
                            },
                            child: const Text("View Terms of Use"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!termsOfUse) {
                          FlushBarTemplate(
                              context,
                              "REGISTER FAILED!",
                              "You may not register without accepting Terms of Use!",
                              false);
                        } else if (_formKey.currentState!.validate() &&
                            termsOfUse) {
                          register(context);
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    ),
                    child: const Text(
                      "Do you have an account?",
                      style: TextStyle(fontSize: 18),
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
