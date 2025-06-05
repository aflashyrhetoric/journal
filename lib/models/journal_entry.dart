import 'package:journal/models/person_mention.dart';
import 'package:journal/utils/time_utils.dart';

class NewJournalEntry {
  final String text;
  final String? title;
  final int? wordCount;
  final String partOfDay;

  NewJournalEntry({
    required this.text,
    this.title,
    this.wordCount,
    required this.partOfDay,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'title': title,
      'word_count': wordCount,
      'part_of_day': partOfDay,
    };
  }
}

class JournalEntry {
  final int id;
  final int userId;
  final String text;
  final String? title;

  // Statistics
  final int wordCount;
  final int uniqueWords = 0;
  final PartOfDay partOfDay;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? namedEntityProcessedAt;

  // Relationships
  final List<PersonMention>? personMentions;

  // Accessor-properties (not persisted, comes from Laravel Eloquent Accessors)
  final String excerpt;

  JournalEntry({
    required this.id,
    required this.userId,
    required this.text,
    this.title,
    required this.wordCount,
    required this.partOfDay,
    required this.createdAt,
    required this.updatedAt,
    required this.excerpt,
    required this.namedEntityProcessedAt,
    required this.personMentions,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      userId: json['user_id'],
      text: json['text'],
      excerpt: json['excerpt'] ?? '',
      title: json['title'],
      wordCount: json['word_count'],
      partOfDay: PartOfDay.values.firstWhere(
        (e) => e.name == json['part_of_day'],
      ),
      personMentions: (json['person_mentions'] as List?)
          ?.map((e) => PersonMention.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      namedEntityProcessedAt: json['named_entity_processed_at'] != null
          ? DateTime.parse(json['named_entity_processed_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'text': text,
      'title': title,
      'word_count': wordCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
