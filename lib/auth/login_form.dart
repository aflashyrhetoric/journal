import 'package:flutter/cupertino.dart';
import 'package:journal/auth/login_service.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback handleToggleMode;

  const LoginForm({super.key, required this.handleToggleMode});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
            onPressed: _handleLogin,
            child: const Text('Login', style: TextStyle(fontSize: 16)),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Need an account?"),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                onPressed: widget.handleToggleMode,
                child: Text("Sign Up", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await LoginService.login(email, password);
      setState(() {});

      if (!mounted) return; // Check if the widget is still mounted

      // Optionally, navigate to another page or show a success message
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Login Failed"),
            content: Text("Something went wrong. Please try again."),
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
