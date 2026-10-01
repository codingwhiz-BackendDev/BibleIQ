import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_state.dart';
import '../../../shared/widgets/app_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Reading Preferences',
            [
              _TextSizeTile(),
              _DarkModeTile(),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Account',
            [
              _SettingsTile(
                icon: Icons.person,
                title: 'Profile',
                subtitle: 'Manage your account',
                onTap: () {
                  // Navigate to profile
                },
              ),
              _SettingsTile(
                icon: Icons.sync,
                title: 'Sync',
                subtitle: 'Sync data across devices',
                onTap: () {
                  // Navigate to sync settings
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Privacy',
            [
              _SettingsTile(
                icon: Icons.lock,
                title: 'Privacy Settings',
                subtitle: 'Control your data',
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
              _SettingsTile(
                icon: Icons.download,
                title: 'Export Data',
                subtitle: 'Download your data',
                onTap: () {
                  // Export data
                },
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
                color: AppColors.error,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'About',
            [
              _SettingsTile(
                icon: Icons.info,
                title: 'About Bible IQ',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement deletion
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Bible IQ'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bible IQ'),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text('Learn to Study the Bible for Yourself'),
            SizedBox(height: 8),
            Text(
              'Bible IQ helps Christians understand Scripture in context, learn responsible interpretation, and develop independent study skills.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _TextSizeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final textSize = appState.textSize;

    return ListTile(
      leading: const Icon(Icons.text_fields),
      title: const Text('Text Size'),
      subtitle: Text('${textSize.toInt()} sp'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              appState.setTextSize(textSize - 2);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              appState.setTextSize(textSize + 2);
            },
          ),
        ],
      ),
    );
  }
}

class _DarkModeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDarkMode = appState.isDarkMode;

    return SwitchListTile(
      secondary: const Icon(Icons.dark_mode),
      title: const Text('Dark Mode'),
      subtitle: const Text('Use dark theme'),
      value: isDarkMode,
      onChanged: (value) {
        appState.toggleDarkMode();
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: color != null ? TextStyle(color: color) : null),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: color ?? AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }
}
