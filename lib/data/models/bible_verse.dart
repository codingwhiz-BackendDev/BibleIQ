class BibleVerse {
  final String bookId;
  final int chapter;
  final int verse;
  final String text;
  final String? translation;

  BibleVerse({
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.text,
    this.translation,
  });

  String get reference => '$bookId $chapter:$verse';

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'chapter': chapter,
      'verse': verse,
      'text': text,
      'translation': translation,
    };
  }

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      bookId: json['bookId'] as String,
      chapter: json['chapter'] as int,
      verse: json['verse'] as int,
      text: json['text'] as String,
      translation: json['translation'] as String?,
    );
  }
}

class BibleChapter {
  final String bookId;
  final int chapter;
  final List<BibleVerse> verses;

  BibleChapter({
    required this.bookId,
    required this.chapter,
    required this.verses,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'chapter': chapter,
      'verses': verses.map((v) => v.toJson()).toList(),
    };
  }

  factory BibleChapter.fromJson(Map<String, dynamic> json) {
    return BibleChapter(
      bookId: json['bookId'] as String,
      chapter: json['chapter'] as int,
      verses: (json['verses'] as List)
          .map((v) => BibleVerse.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }
}
