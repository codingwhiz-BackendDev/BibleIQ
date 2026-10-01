class PassageReference {
  final String bookId;
  final String bookName;
  final int startChapter;
  final int startVerse;
  final int? endChapter;
  final int? endVerse;

  PassageReference({
    required this.bookId,
    required this.bookName,
    required this.startChapter,
    required this.startVerse,
    this.endChapter,
    this.endVerse,
  });

  bool get isSingleVerse => endChapter == null && endVerse == null;

  String get displayReference {
    if (isSingleVerse) {
      return '$bookName $startChapter:$startVerse';
    }
    if (endChapter == startChapter) {
      return '$bookName $startChapter:$startVerse-$endVerse';
    }
    return '$bookName $startChapter:$startVerse-$endChapter:$endVerse';
  }

  PassageReference copyWith({
    String? bookId,
    String? bookName,
    int? startChapter,
    int? startVerse,
    int? endChapter,
    int? endVerse,
  }) {
    return PassageReference(
      bookId: bookId ?? this.bookId,
      bookName: bookName ?? this.bookName,
      startChapter: startChapter ?? this.startChapter,
      startVerse: startVerse ?? this.startVerse,
      endChapter: endChapter ?? this.endChapter,
      endVerse: endVerse ?? this.endVerse,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'bookName': bookName,
      'startChapter': startChapter,
      'startVerse': startVerse,
      'endChapter': endChapter,
      'endVerse': endVerse,
    };
  }

  factory PassageReference.fromJson(Map<String, dynamic> json) {
    return PassageReference(
      bookId: json['bookId'] as String,
      bookName: json['bookName'] as String,
      startChapter: json['startChapter'] as int,
      startVerse: json['startVerse'] as int,
      endChapter: json['endChapter'] as int?,
      endVerse: json['endVerse'] as int?,
    );
  }
}
