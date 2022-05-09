import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/consts.dart';

class AppBarTemplate extends StatefulWidget with PreferredSizeWidget {
  final String title;

  const AppBarTemplate({Key? key, required this.title}) : super(key: key);

  @override
  State<AppBarTemplate> createState() => _AppBarTemplateState();

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.appBarHeight);
}

class _AppBarTemplateState extends State<AppBarTemplate> {
  void logout(context) {
    logoutAuth();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out ;)'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      toolbarHeight: 75,
      leading: const Padding(
        padding: EdgeInsets.zero,
        child: Image(image: AssetImage('assets/app_bar_logo.png')),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () => logout(context),
            child: const Icon(
              Icons.logout,
            ),
          ),
        ),
      ],
    );
  }
}
