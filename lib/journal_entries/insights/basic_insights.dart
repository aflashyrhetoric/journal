import 'package:flutter/widgets.dart';
import 'package:journal/journal_entries/insights/word_count.dart';
import 'package:journal/models/journal_entry.dart';

class BasicInsights extends StatelessWidget {
  final JournalEntry entry;

  const BasicInsights({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          WordCount(entry: entry),
          SizedBox(width: 8),
          WordCount(entry: entry),
          SizedBox(width: 8),
          WordCount(entry: entry),
        ],
      ),
    );
  }
}
