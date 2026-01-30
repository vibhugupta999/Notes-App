
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/Data/Constants/consts.dart';
import 'package:notes/Services/authentication_services.dart';
import 'package:notes/Widgets/messagedialog.dart';

class RegistrationcontrollerProvider extends ChangeNotifier {
  bool _isRegisterMode = true;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool get isRegisterMode => _isRegisterMode;

  bool _isPasswordHidden = true;

  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  bool get isPasswordHidden => _isPasswordHidden;

  String _userName = "";

  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  String get userName => _userName.trim();

  String _email = "";

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = "";

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> authenticateWithEmailandPassword({
    required BuildContext context,
  }) async {
    isLoading = true;
    try {
      if (isRegisterMode) {
        await AuthServices.register(
          username: userName,
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return MessageDialog(
              font: "Serif",
              message:
                  "A verification email was sent to provided email address. Kindly verify your email",
            );
          },
        );
        while (!AuthServices.isEmailVerified) {
          await Future.delayed(
            Duration(seconds: 5),
            () => AuthServices.user?.reload(),
          );
        }
      } else {
        await AuthServices.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return MessageDialog(
            font: "Serif",
            message:
                authExceptionMessages[e.code] ?? "An unknown error occured!",
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            MessageDialog(font: "Serif", message: "An unknown error occured!"),
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> resetPassword({required BuildContext context}) async {
    try {
      await AuthServices.resetPassword(email: email);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return MessageDialog(
              font: "Serif",
              message:
                  "A password reset email has been set to $email!! Open link to reset password",
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return MessageDialog(
            font: "Serif",
            message:
                authExceptionMessages[e.code] ?? "An unknown error occured!",
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            MessageDialog(font: "Serif", message: "An unknown error occured!"),
      );
    }
  }

  Future<void> authenticateWithGoogle({required BuildContext context}) async {
    try {
      await AuthServices.signInWithGoogle();
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            MessageDialog(font: "Serif", message: e.toString()),
      );
    }
  }
}
