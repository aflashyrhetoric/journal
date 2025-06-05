import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:journal/api/api_client.dart';
import 'package:journal/journal_entries/write_edit.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/notifier/journal_entry_notifier.dart';

class JournalEntryCard extends ConsumerStatefulWidget {
  final JournalEntry entry;

  const JournalEntryCard({super.key, required this.entry});

  @override
  ConsumerState<JournalEntryCard> createState() => _JournalEntryCardState();
}

class _JournalEntryCardState extends ConsumerState<JournalEntryCard> {
  late Timer _pollingTimer;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    if (widget.entry.namedEntityProcessedAt == null) {
      _isProcessing = true;
      _startPolling();
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      final response = await ApiClient.get(
        '/api/journal-entries/${widget.entry.id}/ready',
      );
      final data = jsonDecode(response.body);

      final isReady = data['isReady'] ?? false;

      if (isReady) {
        _pollingTimer.cancel();

        // Optional: update local UI state
        setState(() {
          _isProcessing = false;
        });

        // Now fetch the full updated journal entry
        final entryResponse = await ApiClient.get(
          '/api/journal-entries/${widget.entry.id}',
        );
        final entryData = jsonDecode(entryResponse.body);

        final updatedEntry = JournalEntry.fromJson(entryData);

        // Update the global store with the updated entry
        ref.read(journalEntryProvider.notifier).updateSingleEntry(updatedEntry);
      }
    });
  }

  @override
  void dispose() {
    if (_isProcessing) {
      _pollingTimer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final humanReadableDate = DateFormat(
      'MMM d, yyyy • h:mm a',
    ).format(widget.entry.createdAt.toLocal());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => WriteEdit(entry: widget.entry),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.entry.title == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.entry.title!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Text(widget.entry.excerpt, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  humanReadableDate,
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 16,
                  ),
                ),
                _isProcessing
                    ? Text(widget.entry.namedEntityProcessedAt.toString())
                    : Text(widget.entry.namedEntityProcessedAt.toString()),
                _isProcessing
                    ? CupertinoActivityIndicator()
                    : const Text("Lol"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
