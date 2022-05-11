import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/changeEmail/changeEmail.dart';
import 'package:hard_and_soft_mobile/src/changePassword/changePassword.dart';
import 'package:hard_and_soft_mobile/src/deleteAccount/deleteAccount.dart';
import 'package:hard_and_soft_mobile/src/forgotPassword/forgotPassowrd.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void forgotPassword() async {
    bool success = await forgotPasswordAuth(getEmailCurrentUser()!);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('A recover link has been sent to ${getEmailCurrentUser()}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recover account failed :('),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12.5, 50, 12.5, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            title: const Text("Forgot Password"),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () => forgotPassword(),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(12.5, 5, 12.5, 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
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
        ),
      ],
    );
  }
}
