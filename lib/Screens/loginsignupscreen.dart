import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/Provider/registrationcontroller.dart';
import 'package:notes/Widgets/customelevatedbuttons.dart';
import 'package:notes/Widgets/customtextfield.dart';
import 'package:notes/core/validators.dart';
import 'package:provider/provider.dart';

class Loginsignupscreen extends StatefulWidget {
  const Loginsignupscreen({super.key});

  @override
  State<Loginsignupscreen> createState() => _LoginsignupscreenState();
}

class _LoginsignupscreenState extends State<Loginsignupscreen> {
  late final RegistrationcontrollerProvider registrationcontrollerProvider;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formkey;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();

    emailController = TextEditingController();

    passwordController = TextEditingController();

    formkey = GlobalKey();

    registrationcontrollerProvider = context.read();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationcontrollerProvider, bool>(
                selector: (_, controller) => controller.isRegisterMode,
                builder: (_, isRegisterMode, __) => Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isRegisterMode ? "Register" : "Sign In",
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: Theme.of(
                            context,
                          ).textTheme.titleLarge!.fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "To save your notes to the cloud , Register / Sign in to the app",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Theme.of(
                            context,
                          ).textTheme.titleLarge!.fontFamily,
                        ),
                      ),
                      SizedBox(height: 48),
                      if (isRegisterMode) ...[
                        CustomTextFormField(
                          controller: nameController,
                          labelText: "Username",
                          filled: true,
                          fillColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          validator: Validators.nameValidator,
                          onChanged: (value) {
                            registrationcontrollerProvider.userName = value;
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                      CustomTextFormField(
                        controller: emailController,
                        labelText: "Email Address",
                        filled: true,
                        fillColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.emailValidator,
                        onChanged: (value) {
                          registrationcontrollerProvider.email = value;
                        },
                      ),
                      SizedBox(height: 8),
                      Selector<RegistrationcontrollerProvider, bool>(
                        selector: (_, controller) =>
                            controller.isPasswordHidden,
                        builder: (_, isPasswordHidden, __) =>
                            CustomTextFormField(
                              controller: passwordController,
                              labelText: "Password",
                              filled: true,
                              fillColor: Colors.white,
                              obSecureText: isPasswordHidden,
                              keyboardType: TextInputType.visiblePassword,
                              validator: Validators.passwordValidator,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  registrationcontrollerProvider
                                          .isPasswordHidden =
                                      !isPasswordHidden;
                                },
                                child: Icon(
                                  isPasswordHidden
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                ),
                              ),
                              onChanged: (value) {
                                registrationcontrollerProvider.password = value;
                              },
                            ),
                      ),
                      SizedBox(height: 16),

                      if (!isRegisterMode) ...[
                        GestureDetector(
                          onTap: () {
                            registrationcontrollerProvider.resetPassword(
                              context: context,
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],

                      Selector<RegistrationcontrollerProvider, bool>(
                        selector: (_, controller) => controller.isLoading,
                        builder: (_, isLoading, __) => CustomElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formkey.currentState?.validate() ??
                                      false) {
                                    registrationcontrollerProvider
                                        .authenticateWithEmailandPassword(
                                          context: context,
                                        );
                                  }
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: const CircularProgressIndicator(),
                                )
                              : Text(
                                  isRegisterMode
                                      ? "Create my Account"
                                      : "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 32),

                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Text(
                            isRegisterMode
                                ? "    Or register with    "
                                : "    Or sign in with    ",
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {
                                registrationcontrollerProvider
                                    .authenticateWithGoogle(context: context);
                              },
                              child: Icon(FontAwesomeIcons.google, size: 22),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {},
                              child: Icon(FontAwesomeIcons.facebook, size: 22),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32),
                      Text.rich(
                        TextSpan(
                          text: isRegisterMode
                              ? "Already have an account? "
                              : "Don't have an account?",
                          style: TextStyle(color: Colors.grey.shade700),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  registrationcontrollerProvider
                                          .isRegisterMode =
                                      !isRegisterMode;
                                },
                              text: isRegisterMode ? "Sign in" : "Register",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
