enum Testament {
  oldTestament,
  newTestament,
}

enum BookGenre {
  law,
  history,
  wisdom,
  poetry,
  prophecy,
  gospel,
  epistle,
  apocalyptic,
}

class BibleBook {
  final String id;
  final String name;
  final String? abbreviation;
  final int chapters;
  final Testament testament;
  final BookGenre genre;
  final String? author;
  final int? chapterEstimate;

  BibleBook({
    required this.id,
    required this.name,
    this.abbreviation,
    required this.chapters,
    required this.testament,
    required this.genre,
    this.author,
    this.chapterEstimate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'chapters': chapters,
      'testament': testament.index,
      'genre': genre.index,
      'author': author,
      'chapterEstimate': chapterEstimate,
    };
  }

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      id: json['id'] as String,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
      chapters: json['chapters'] as int,
      testament: Testament.values[json['testament'] as int],
      genre: BookGenre.values[json['genre'] as int],
      author: json['author'] as String?,
      chapterEstimate: json['chapterEstimate'] as int?,
    );
  }
}
