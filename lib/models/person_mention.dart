class PersonMention {
  final int id;
  final int userId;
  final int personId;
  final int journalEntryId;
  final double sentiment;
  final List<String> snippets;
  final DateTime createdAt;
  final DateTime updatedAt;

  PersonMention({
    required this.id,
    required this.userId,
    required this.personId,
    required this.journalEntryId,
    required this.sentiment,
    required this.snippets,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PersonMention.fromJson(Map<String, dynamic> json) {
    return PersonMention(
      id: json['id'],
      userId: json['user_id'],
      personId: json['person_id'],
      journalEntryId: json['journal_entry_id'],
      sentiment: json['sentiment'].toDouble(),
      snippets: List<String>.from(json['snippets']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'person_id': personId,
      'journal_entry_id': journalEntryId,
      'sentiment': sentiment,
      'snippets': snippets,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
