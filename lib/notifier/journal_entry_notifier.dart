import 'dart:convert';
import 'package:journal/api/api_client.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalEntryNotifier extends Notifier<List<JournalEntry>> {
  @override
  List<JournalEntry> build() {
    // Initial state
    return [];
  }

  Future<void> fetchEntries() async {
    try {
      final response = await ApiClient.get('/api/journal-entries');
      final data = jsonDecode(response.body);
      final entriesJson = data is List ? data : data['entries'];

      state = entriesJson
          .map<JournalEntry>((json) => JournalEntry.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching journal entries: $e');
      state = [];
    }
  }

  Future<bool> addEntry(NewJournalEntry entry) async {
    try {
      await ApiClient.post('/api/journal-entries', entry.toJson());

      // Option 1: simple re-fetch
      await fetchEntries();

      return true;
    } catch (e) {
      print('Error adding journal entry: $e');
      return false;
    }
  }

  Future<void> updateEntry(int id, NewJournalEntry entry) async {
    try {
      await ApiClient.put('/api/journal-entries/$id', entry.toJson());

      // Option 1: simple re-fetch
      await fetchEntries();

      // Option 2 (optimistic update — more advanced):
      // state =
      //     state.map((e) => e.id == id ? entry : e).toList()
      //         as List<JournalEntry>;
    } catch (e) {
      print('Error updating journal entry: $e');
    }
  }

  void updateSingleEntry(JournalEntry updatedEntry) {
    state = state.map((entry) {
      return entry.id == updatedEntry.id ? updatedEntry : entry;
    }).toList();
  }
}

final journalEntryProvider =
    NotifierProvider<JournalEntryNotifier, List<JournalEntry>>(
      JournalEntryNotifier.new,
    );
