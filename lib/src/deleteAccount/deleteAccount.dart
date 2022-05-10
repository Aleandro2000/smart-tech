import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully deleted account ;)'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deleting account failed :('),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Account"),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Image(image: AssetImage('assets/logo.png')),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: const Text(
                "Are you sure you want to delete this account? This process is not reversible!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Container(
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
                  hintText: 'Your Password for Deleting',
                ),
              ),
            ),
            TextButton(
              onPressed: () => delete(context),
              child: const Text("Yes, I want to delete this account!"),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
                padding: const EdgeInsets.all(12.5),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 75),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("No, I don't want to continue this process!"),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.all(12.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
