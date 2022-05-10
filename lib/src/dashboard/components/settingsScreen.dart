import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/changeEmail/changeEmail.dart';
import 'package:hard_and_soft_mobile/src/changePassword/changePassword.dart';
import 'package:hard_and_soft_mobile/src/deleteAccount/deleteAccount.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: const Text("Change Email"),
          leading: const Icon(Icons.email),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChangeEmail()),
          ),
        ),
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: const Text("Change Password"),
          leading: const Icon(Icons.password),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChangePassword()),
          ),
        ),
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: const Text("Delete Account"),
          leading: const Icon(Icons.delete),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DeleteAccount()),
          ),
        ),
      ],
    );
  }
}
