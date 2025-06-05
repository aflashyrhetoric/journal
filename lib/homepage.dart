import 'package:flutter/cupertino.dart';
import 'package:journal/journal_entries/journal_index.dart';
import 'package:journal/journal_entries/write.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeContent(context);
  }

  Widget _buildHomeContent(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CupertinoColors.systemGrey.withOpacity(0.1),
                  CupertinoColors.systemGrey.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(child: JournalIndex()),
          ),

          Positioned(
            bottom: 48,
            right: 0,
            left: 0,
            child: Center(
              child: SizedBox(
                width: 16 * 5,
                height: 16 * 5,
                child: CupertinoButton.tinted(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) =>
                            Write(), // Replace with your journal entry creation page
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(100),
                  padding: EdgeInsets.zero,
                  child: Text("+", style: TextStyle(fontSize: 32)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
