import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';

class KnowledgeHomeScreen extends StatelessWidget {
  const KnowledgeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Knowledge Explorer',
      showBackButton: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 24),
              _buildCategories(context),
              const SizedBox(height: 24),
              _buildFeaturedTopics(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for doctrines, people, places, themes...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _CategoryCard(
              icon: Icons.account_balance,
              label: 'Doctrines',
              color: AppColors.primary,
              onTap: () {
                // Navigate to doctrines
              },
            ),
            _CategoryCard(
              icon: Icons.person,
              label: 'People',
              color: AppColors.accent,
              onTap: () {
                // Navigate to people
              },
            ),
            _CategoryCard(
              icon: Icons.place,
              label: 'Places',
              color: AppColors.info,
              onTap: () {
                // Navigate to places
              },
            ),
            _CategoryCard(
              icon: Icons.category,
              label: 'Themes',
              color: AppColors.warning,
              onTap: () {
                // Navigate to themes
              },
            ),
            _CategoryCard(
              icon: Icons.menu_book,
              label: 'Books',
              color: AppColors.success,
              onTap: () {
                // Navigate to books
              },
            ),
            _CategoryCard(
              icon: Icons.event,
              label: 'Events',
              color: AppColors.error,
              onTap: () {
                // Navigate to events
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedTopics(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Topics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        _TopicCard(
          title: 'The Trinity',
          subtitle: 'One God in three persons',
          icon: Icons.account_balance,
          color: AppColors.primary,
          onTap: () {
            _showTopicDetail(context, 'The Trinity');
          },
        ),
        const SizedBox(height: 8),
        _TopicCard(
          title: 'The Incarnation',
          subtitle: 'God becoming human',
          icon: Icons.person,
          color: AppColors.accent,
          onTap: () {
            _showTopicDetail(context, 'The Incarnation');
          },
        ),
        const SizedBox(height: 8),
        _TopicCard(
          title: 'Justification by Faith',
          subtitle: 'Declared righteous through faith',
          icon: Icons.gavel,
          color: AppColors.info,
          onTap: () {
            _showTopicDetail(context, 'Justification by Faith');
          },
        ),
      ],
    );
  }

  void _showTopicDetail(BuildContext context, String topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _TopicDetailScreen(topic: topic),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TopicCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
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

class _TopicDetailScreen extends StatelessWidget {
  final String topic;

  const _TopicDetailScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: topic,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContentSection(
              title: 'Definition',
              content: 'This is a sample entry for the Knowledge Explorer. When fully implemented, this section will provide a clear, concise definition of the theological concept.',
            ),
            const SizedBox(height: 16),
            _ContentSection(
              title: 'Biblical Foundations',
              content: 'Relevant Bible passages that teach about this doctrine will be listed here with explanations of how they contribute to our understanding.',
            ),
            const SizedBox(height: 16),
            _ContentSection(
              title: 'Historical Context',
              content: 'Historical development of this doctrine within Christian theology will be presented, including key figures and councils.',
            ),
            const SizedBox(height: 16),
            _ContentSection(
              title: 'Key Passages',
              content: 'John 1:1, Colossians 1:15-20, Hebrews 1:1-3',
            ),
            const SizedBox(height: 16),
            _ContentSection(
              title: 'Related Topics',
              content: 'Christology, God\'s Attributes, Creation',
            ),
            const SizedBox(height: 24),
            Card(
              color: AppColors.warning.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warning),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This is sample content. The full Knowledge Explorer will provide verified, scholarly content for each topic.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final String title;
  final String content;

  const _ContentSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
              ),
        ),
      ],
    );
  }
}
