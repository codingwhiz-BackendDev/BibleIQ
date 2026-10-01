import 'package:flutter/material.dart';
import '../../../data/models/bible_book.dart';
import '../../../features/bible/models/bible_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import 'bible_home_screen.dart';
import 'chapter_selection_screen.dart';

class BookSelectionScreen extends StatelessWidget {
  final TestamentType testamentType;

  const BookSelectionScreen({
    super.key,
    required this.testamentType,
  });

  @override
  Widget build(BuildContext context) {
    final books = BibleData.getAllBooks().where((book) {
      return testamentType == TestamentType.oldTestament
          ? book.testament == Testament.oldTestament
          : book.testament == Testament.newTestament;
    }).toList();

    return AppScaffold(
      title: testamentType == TestamentType.oldTestament
          ? 'Old Testament'
          : 'New Testament',
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _BookListItem(
            book: book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterSelectionScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _BookListItem extends StatelessWidget {
  final BibleBook book;
  final VoidCallback onTap;

  const _BookListItem({
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    book.chapters.toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${book.chapters} chapters',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
