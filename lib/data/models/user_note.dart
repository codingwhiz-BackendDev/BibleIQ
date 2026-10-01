import 'passage_reference.dart';

enum NoteType {
  observation,
  interpretation,
  application,
  question,
  general,
}

class UserNote {
  final String id;
  final PassageReference reference;
  final String content;
  final NoteType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final bool isHighlighted;
  final String? highlightColor;

  UserNote({
    required this.id,
    required this.reference,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.isHighlighted = false,
    this.highlightColor,
  });

  UserNote copyWith({
    String? id,
    PassageReference? reference,
    String? content,
    NoteType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    bool? isHighlighted,
    String? highlightColor,
  }) {
    return UserNote(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference.toJson(),
      'content': content,
      'type': type.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'isHighlighted': isHighlighted,
      'highlightColor': highlightColor,
    };
  }

  factory UserNote.fromJson(Map<String, dynamic> json) {
    return UserNote(
      id: json['id'] as String,
      reference: PassageReference.fromJson(
          json['reference'] as Map<String, dynamic>),
      content: json['content'] as String,
      type: NoteType.values[json['type'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      tags: (json['tags'] as List).map((e) => e as String).toList(),
      isHighlighted: json['isHighlighted'] as bool? ?? false,
      highlightColor: json['highlightColor'] as String?,
    );
  }
}
