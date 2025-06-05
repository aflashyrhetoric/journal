import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

CupertinoThemeData get oneLightTheme => CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF526FFF), // accent: focusBorder, cursor, badge
  // scaffoldBackgroundColor: Color(0xFFFAFAFA), // editor background
  scaffoldBackgroundColor: Color(0xFFEBEAF0), // editor background
  // Text styling fallback
  textTheme: CupertinoTextThemeData(
    navLargeTitleTextStyle: TextStyle(
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      // fontWeight: FontWeight.w700,
      fontSize: 32,
      color: Color(0xFF121417),
    ), // activityBar.foreground
    textStyle: TextStyle(
      fontFamily: GoogleFonts.alegreyaSans().fontFamily,
      fontSize: 18,
      height: 1.25,
      color: Color(0xFF383A42),
    ), // editor.foreground
    primaryColor: Color(
      0xFF121417,
    ), // strong dark text (activityBar.foreground)
  ),

  // Bar background colors
  barBackgroundColor: Color(0xFFEAEAEB), // sidebar/status/tab background
);
