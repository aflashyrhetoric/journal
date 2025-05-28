import 'package:flutter/cupertino.dart';
import 'package:journal/auth/logout_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Home')),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to the Home Page!',
              style: CupertinoTheme.of(
                context,
              ).textTheme.navLargeTitleTextStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoButton(
              onPressed: () async {
                await LogoutService.logout();
                setState(() {});
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
