import 'package:flutter/cupertino.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home, size: 20),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person, size: 20),
          label: 'Profile',
        ),
      ],
    );
  }
}
