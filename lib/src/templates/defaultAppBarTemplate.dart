import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/utils/auth.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';

class DefaultAppBarTemplate extends StatefulWidget with PreferredSizeWidget {
  final String title;

  const DefaultAppBarTemplate({Key? key, required this.title})
      : super(key: key);

  @override
  State<DefaultAppBarTemplate> createState() => _DefaultAppBarTemplateState();

  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _DefaultAppBarTemplateState extends State<DefaultAppBarTemplate> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      toolbarHeight: 75,
      centerTitle: true,
      shadowColor: Colors.black,
      elevation: 10,
      actions: const [
        Padding(
          padding: EdgeInsets.zero,
          child: Image(image: AssetImage('assets/app_bar_logo.png')),
        ),
      ],
    );
  }
}
