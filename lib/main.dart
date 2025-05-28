import 'package:flutter/cupertino.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:journal/auth_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:journal/homepage.dart';
import 'themes/one_light.dart';

Future main() async {
  // Load environment variables
  await dotenv.load();
  print("Env var is: ${dotenv.env['IS_PRODUCTION']}");

  // ! Execute main program.
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Create a secure storage instance
  static const _storage = FlutterSecureStorage();

  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: "authToken");

    // log the token for debugging purposes
    // print("Auth Token: $token");

    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: oneLightTheme, // Apply the theme here
      home: FutureBuilder<bool>(
        future: isAuthenticated(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CupertinoPageScaffold(
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          final isAuthenticated = snapshot.data!;
          return isAuthenticated ? HomePage() : AuthPage();
        },
      ),
    );
  }
}
