
class Validators {
  Validators._();

  static String? nameValidator(String? name) {
    name = name?.trim() ?? "";
    return name.isEmpty ? "Please enter your name" : null;
  }

  static const _emailPattern =
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

  

  static String? emailValidator(String? email) {
    email = email?.trim() ?? "";
    return email.isEmpty
        ? "Please enter your email address"
        : !RegExp(_emailPattern).hasMatch(email)
        ? "Email is not valid"
        : null;
  }

  static String? passwordValidator(String? password) {
    password = password ?? "";

    String errorMessage = "";

    if (password.isEmpty) {
      errorMessage = "Password is empty";
    } else if (password.length < 6) {
      errorMessage = "Password must be atleast 6 characters long!";
    }

    if (password.contains(RegExp('r[a-z]'))) {
      errorMessage =
          "$errorMessage\nPassword must contain atleast one lower case character!";
    }

    if (password.contains(RegExp('r[A-Z]'))) {
      errorMessage =
          "$errorMessage\nPassword must contain atleast one upper case character!";
    }

    if (password.contains(RegExp('r[0-9]'))) {
      errorMessage = "$errorMessage\nPassword must contain atleast one number";
    }

    return errorMessage.isEmpty ? null : errorMessage.trim();
  }
}
