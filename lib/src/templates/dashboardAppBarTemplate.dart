import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/templates/flushBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';

class DashboardAppBarTemplate extends StatefulWidget with PreferredSizeWidget {
  final String title;

  const DashboardAppBarTemplate({Key? key, required this.title})
      : super(key: key);

  @override
  State<DashboardAppBarTemplate> createState() =>
      _DashboardAppBarTemplateState();

  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _DashboardAppBarTemplateState extends State<DashboardAppBarTemplate> {
  void logout(context) {
    logoutAuth();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    FlushBarTemplate(
        context, "LOG OUT MESSAGE!", "Successfully logged out! ;)", false);
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
      shadowColor: Colors.black,
      elevation: 10,
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
