import "package:flutter/material.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: Text("Change Email"),
          leading: Icon(Icons.email),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: null,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: Text("Change Password"),
          leading: Icon(Icons.password),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: null,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          title: Text("Delete Account"),
          leading: Icon(Icons.delete),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: null,
        ),
      ],
    );
  }
}
