import 'package:flutter/material.dart';
import '../../../data/models/bible_book.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import 'bible_reader_screen.dart';

class ChapterSelectionScreen extends StatelessWidget {
  final BibleBook book;

  const ChapterSelectionScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: book.name,
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: book.chapters,
        itemBuilder: (context, index) {
          final chapterNum = index + 1;
          return _ChapterButton(
            chapter: chapterNum,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BibleReaderScreen(
                    bookId: book.id,
                    bookName: book.name,
                    chapter: chapterNum,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ChapterButton extends StatelessWidget {
  final int chapter;
  final VoidCallback onTap;

  const _ChapterButton({
    required this.chapter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            chapter.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
          ),
        ),
      ),
    );
  }
}
