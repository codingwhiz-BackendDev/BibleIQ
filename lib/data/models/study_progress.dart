class StudyProgress {
  final String id;
  final String lessonId;
  final String lessonTitle;
  final double completionPercentage;
  final DateTime lastAccessed;
  final bool isCompleted;

  StudyProgress({
    required this.id,
    required this.lessonId,
    required this.lessonTitle,
    required this.completionPercentage,
    required this.lastAccessed,
    this.isCompleted = false,
  });

  StudyProgress copyWith({
    String? id,
    String? lessonId,
    String? lessonTitle,
    double? completionPercentage,
    DateTime? lastAccessed,
    bool? isCompleted,
  }) {
    return StudyProgress(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'lessonTitle': lessonTitle,
      'completionPercentage': completionPercentage,
      'lastAccessed': lastAccessed.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory StudyProgress.fromJson(Map<String, dynamic> json) {
    return StudyProgress(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      lessonTitle: json['lessonTitle'] as String,
      completionPercentage: json['completionPercentage'] as double,
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
