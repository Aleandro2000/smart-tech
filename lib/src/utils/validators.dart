String? requiredValidation(String text) {
  if (text.isEmpty) {
    return "Required input!";
  } else {
    return null;
  }
}

String? strongPasswordValidation(String password) {
  if (!RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  ).hasMatch(password)) {
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
