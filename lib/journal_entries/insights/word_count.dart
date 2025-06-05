import 'package:flutter/widgets.dart';
import 'package:journal/models/journal_entry.dart';

class WordCount extends StatelessWidget {
  final JournalEntry entry;
  const WordCount({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            entry.wordCount.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Words', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
