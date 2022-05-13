// ignore_for_file: non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';

void FlushBarTemplate(
    BuildContext context, String title, String text, bool lower) {
  if (lower) {
    Flushbar(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 25, 8, 0),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: ThemeColors.flusBarItemColor,
      title: title.trim().toUpperCase(),
      message: text.trim(),
      duration: const Duration(seconds: 3),
    ).show(context);
  } else {
    Flushbar(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: ThemeColors.flusBarItemColor,
      title: title.trim().toUpperCase(),
      message: text.trim(),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
