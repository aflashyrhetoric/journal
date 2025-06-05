import 'package:flutter/cupertino.dart';

CupertinoTabBar appNavbar() => CupertinoTabBar(
  items: [
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
