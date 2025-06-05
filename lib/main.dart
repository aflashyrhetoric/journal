import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal/auth/auth_store.dart';
import 'package:journal/auth_page.dart';
import 'package:journal/homepage.dart';
import 'package:journal/themes/one_light.dart';

Future main() async {
  // Load environment variables
  await dotenv.load();

  // Run app inside ProviderScope — ONLY HERE
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(
      authStoreProvider.select((store) => store.isLoggedIn),
    );

    // Show splash / loading until initialized
    if (!authStore.isInitialized) {
      return const CupertinoApp(
        home: Center(child: CupertinoActivityIndicator()),
      );
    }

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: oneLightTheme,
      home: isLoggedIn ? const HomePage() : const AuthPage(),
    );
  }
}
