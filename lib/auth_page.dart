import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/auth/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        key: Key("auth_page_stack"),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 1.0,
              child: Container(color: CupertinoTheme.of(context).primaryColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/illustrations/pineapple.svg',
                    width: 100,
                    height: 100, // Set proper height here
                  ),
                  Container(padding: const EdgeInsets.only(top: 8, bottom: 0)),
                  Text(
                    "Join Pineapple",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white,
                    ),
                  ),
                  Container(padding: const EdgeInsets.only(top: 12, bottom: 0)),
                  Text(
                    "Insightful journaling is just around the corner.",
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navLargeTitleTextStyle
                        .copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: CupertinoColors.white,
                        ),
                  ),
                  Container(padding: const EdgeInsets.only(top: 0, bottom: 32)),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withAlpha(64),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: AuthForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
