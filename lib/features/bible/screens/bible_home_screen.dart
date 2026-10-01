import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_scaffold.dart';
import 'book_selection_screen.dart';
import 'bible_reader_screen.dart';

class BibleHomeScreen extends StatelessWidget {
  const BibleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Bible',
      showBackButton: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTestamentSection(
                context,
                'Old Testament',
                '39 books',
                AppColors.primary,
                TestamentType.oldTestament,
              ),
              const SizedBox(height: 24),
              _buildTestamentSection(
                context,
                'New Testament',
                '27 books',
                AppColors.accent,
                TestamentType.newTestament,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestamentSection(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    TestamentType type,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookSelectionScreen(testamentType: type),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  type == TestamentType.oldTestament
                      ? Icons.book
                      : Icons.menu_book,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TestamentType {
  oldTestament,
  newTestament,
}
