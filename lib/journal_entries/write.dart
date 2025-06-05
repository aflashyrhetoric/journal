import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/notifier/journal_entry_notifier.dart';
import 'package:journal/utils/time_utils.dart';

class Write extends StatefulWidget {
  const Write({super.key});

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.transparent,
        automaticBackgroundVisibility: false,
        middle: const Text(
          'New Entry',
          style: TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
        ),
        trailing: Consumer(
          builder: (context, ref, child) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                final text = _contentController.text.trim();
                if (text.isEmpty) {
                  // Optionally show error or ignore
                  return;
                }

                // Create new JournalEntry model (fill required fields)
                final newEntry = NewJournalEntry(
                  text: text,
                  title: null, // Add title if needed
                  wordCount: text.split(' ').length,
                  partOfDay: TimeUtils.getCurrentPartOfDay().name,
                );

                final success = await ref
                    .read(journalEntryProvider.notifier)
                    .addEntry(newEntry);

                if (success && context.mounted) {
                  // After success, pop back
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _contentController,
                  placeholder: 'Start writing...',
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textAlignVertical: TextAlignVertical.top,
                  autocorrect: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    // fontFamily: GoogleFonts.domine().fontFamily,
                    color: CupertinoColors.label,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.transparent,
                    border: null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  maxLines: null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
