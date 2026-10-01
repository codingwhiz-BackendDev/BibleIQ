import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'My Library',
      showBackButton: false,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Notes'),
              Tab(text: 'Bookmarks'),
              Tab(text: 'Highlights'),
              Tab(text: 'Studies'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotesTab(),
                _buildBookmarksTab(),
                _buildHighlightsTab(),
                _buildStudiesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return _buildEmptyState(
      icon: Icons.note_add,
      title: 'No notes yet',
      subtitle: 'Your personal notes will appear here',
    );
  }

  Widget _buildBookmarksTab() {
    return _buildEmptyState(
      icon: Icons.bookmark_border,
      title: 'No bookmarks yet',
      subtitle: 'Bookmarked passages will appear here',
    );
  }

  Widget _buildHighlightsTab() {
    return _buildEmptyState(
      icon: Icons.highlight,
      title: 'No highlights yet',
      subtitle: 'Highlighted verses will appear here',
    );
  }

  Widget _buildStudiesTab() {
    return _buildEmptyState(
      icon: Icons.auto_stories,
      title: 'No saved studies yet',
      subtitle: 'Saved contextual studies will appear here',
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
