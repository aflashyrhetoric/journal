import 'package:flutter/cupertino.dart';
import 'package:journal/auth/login_form.dart';
import 'package:journal/auth/signup_form.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String mode = "login";

  void toggleMode() {
    setState(() {
      mode = mode == "signup" ? "login" : "signup";
    });
  }

  bool get isSignup => mode == "signup";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSignup
          ? SignupForm(handleToggleMode: toggleMode)
          : LoginForm(handleToggleMode: toggleMode),
    );
  }
}
