import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/changeEmail/changeEmail.dart';
import 'package:hard_and_soft_mobile/src/changePassword/changePassword.dart';
import 'package:hard_and_soft_mobile/src/deleteAccount/deleteAccount.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void forgotPassword() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Forgot Password"),
            content: const Text("Are you sure you want to continue?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    bool success =
                        await forgotPasswordAuth(getEmailCurrentUser()!);
                    if (success) {
                      FlushBarTemplate(
                          context,
                          "RECOVER PROCESS SUCCESSFULLY!",
                          'A email recover account link has been sent to ${getEmailCurrentUser()}',
                          true);
                    } else {
                      FlushBarTemplate(context, "RECOVER PROCESS FAILED!",
                          "Something is wrong! :(", true);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("YES")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NO")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          alignment: Alignment.center,
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
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          alignment: Alignment.center,
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
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          alignment: Alignment.center,
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
            leading: const Icon(Icons.question_mark),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () => forgotPassword(),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          alignment: Alignment.center,
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
