String? requiredValidation(String text) {
  if (text.isEmpty) {
    return "Required input!";
  } else {
    return null;
  }
}

String? strongPasswordValidation(String text) {
  RegExp regExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  if (!regExp.hasMatch(text)) {
    return "Weak password!";
  } else {
    return null;
  }
}
