import 'package:flutter/cupertino.dart';
import 'package:journal/auth/signup_service.dart';

class SignupForm extends StatefulWidget {
  final VoidCallback handleToggleMode;

  const SignupForm({super.key, required this.handleToggleMode});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoTextField(
          controller: nameController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          style: const TextStyle(fontSize: 16),
          placeholder: "Name",
        ),
        Container(padding: const EdgeInsets.only(bottom: 16)),
        CupertinoTextField(
          controller: emailController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          style: const TextStyle(fontSize: 16),
          placeholder: "E-mail",
        ),
        Container(padding: const EdgeInsets.only(bottom: 16)),
        CupertinoTextField(
          placeholder: 'Password',
          controller: passwordController,
          obscureText: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          style: const TextStyle(fontSize: 16),
        ),
        Container(padding: const EdgeInsets.only(bottom: 16)),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onPressed: _handleSignup,
            child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                onPressed: widget.handleToggleMode,
                child: Text("Login", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSignup() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await SignupService.signup(name, email, password);
      setState(() {});

      if (!mounted) return; // Check if the widget is still mounted
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Sign Up Failed"),
            content: Text("Something went wrong. Please try again later."),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
