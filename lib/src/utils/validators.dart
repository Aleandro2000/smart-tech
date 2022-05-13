import "package:password_strength/password_strength.dart";

String? requiredValidation(String text) {
  if (text.isEmpty) {
    return "Required input!";
  } else {
    return null;
  }
}

String? strongPasswordValidation(String password) {
  if (estimatePasswordStrength(password) < 0.3) {
    return "Weak password!";
  } else {
    return null;
  }
}

String? emailValidator(String email) {
  if (!RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email)) {
    return "Invalid email!";
  } else {
    return null;
  }
}
