import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

final oneLightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF526FFF), // accent: focusBorder, cursor, badge
  scaffoldBackgroundColor: Color(0xFFFAFAFA), // editor background
  // Text styling fallback
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontFamily: GoogleFonts.inter().fontFamily,
      color: Color(0xFF383A42),
    ), // editor.foreground
    primaryColor: Color(
      0xFF121417,
    ), // strong dark text (activityBar.foreground)
  ),

  // Bar background colors
  barBackgroundColor: Color(0xFFEAEAEB), // sidebar/status/tab background
);
