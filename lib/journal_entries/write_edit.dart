import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/journal_entries/insights/basic_insights.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/notifier/journal_entry_notifier.dart';
import 'package:journal/utils/time_utils.dart';

class WriteEdit extends StatefulWidget {
  final JournalEntry entry;

  const WriteEdit({super.key, required this.entry});

  @override
  State<WriteEdit> createState() => _WriteEditState();
}

class _WriteEditState extends State<WriteEdit> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry.title ?? '');
    _contentController = TextEditingController(text: widget.entry.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> handleUpdate(BuildContext context, WidgetRef ref) async {
    final text = _contentController.text.trim();
    if (text.isEmpty) {
      return;
    }

    final title = _titleController.text.trim().isEmpty
        ? null
        : _titleController.text.trim();

    final newEntry = NewJournalEntry(
      text: text,
      title: title,
      wordCount: text.split(' ').length,
      partOfDay: TimeUtils.getCurrentPartOfDay().name,
    );

    // Placeholder — once you add updateEntry(), use this
    ref
        .read(journalEntryProvider.notifier)
        .updateEntry(widget.entry.id, newEntry);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.transparent,
        automaticBackgroundVisibility: false,
        middle: Text(
          'Edit Entry',
          style: const TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
        ),
        trailing: Consumer(
          builder: (context, ref, child) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await handleUpdate(context, ref);
              },
              child: Text('Update'),
            );
          },
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
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
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: BasicInsights(entry: widget.entry),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _titleController,
                            placeholder: 'Title (optional)',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.label,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.transparent,
                              border: null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoTextField(
                        controller: _contentController,
                        placeholder: 'Start writing...',
                        crossAxisAlignment: CrossAxisAlignment.end,
                        textAlignVertical: TextAlignVertical.top,
                        autocorrect: true,
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.4,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          // fontFamily: GoogleFonts.alegreyaSans().fontFamily,
                          color: CupertinoColors.label,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.transparent,
                          border: null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
