import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/bible_verse.dart';
import '../../../data/models/passage_reference.dart';
import '../../../features/bible/models/bible_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_state.dart';
import '../../../shared/widgets/app_scaffold.dart';

class BibleReaderScreen extends StatefulWidget {
  final String bookId;
  final String bookName;
  final int chapter;

  const BibleReaderScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.chapter,
  });

  @override
  State<BibleReaderScreen> createState() => _BibleReaderScreenState();
}

class _BibleReaderScreenState extends State<BibleReaderScreen> {
  BibleChapter? _chapterData;
  int? _selectedVerse;
  int? _selectedEndVerse;
  bool _isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    _loadChapter();
    _saveReadingLocation();
  }

  void _loadChapter() {
    setState(() {
      _chapterData = BibleData.getJohnChapter(widget.chapter);
    });
  }

  void _saveReadingLocation() {
    final appState = context.read<AppState>();
    appState.setLastReadingLocation(
      PassageReference(
        bookId: widget.bookId,
        bookName: widget.bookName,
        startChapter: widget.chapter,
        startVerse: 1,
      ),
    );
  }

  void _navigateToChapter(int newChapter) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BibleReaderScreen(
          bookId: widget.bookId,
          bookName: widget.bookName,
          chapter: newChapter,
        ),
      ),
    );
  }

  void _onVerseTap(int verseNum) {
    if (!_isSelectionMode) {
      setState(() {
        _isSelectionMode = true;
        _selectedVerse = verseNum;
      });
    } else {
      if (_selectedVerse == null) {
        setState(() {
          _selectedVerse = verseNum;
        });
      } else if (_selectedEndVerse == null) {
        if (verseNum >= _selectedVerse!) {
          setState(() {
            _selectedEndVerse = verseNum;
          });
        } else {
          setState(() {
            _selectedVerse = verseNum;
          });
        }
      } else {
        setState(() {
          _isSelectionMode = false;
          _selectedVerse = null;
          _selectedEndVerse = null;
        });
      }
    }
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedVerse = null;
      _selectedEndVerse = null;
    });
  }

  void _openStudyOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _StudyOptionsSheet(
        reference: PassageReference(
          bookId: widget.bookId,
          bookName: widget.bookName,
          startChapter: widget.chapter,
          startVerse: _selectedVerse!,
          endChapter: widget.chapter,
          endVerse: _selectedEndVerse,
        ),
        onStudy: () {
          Navigator.pop(context);
          _clearSelection();
          // Navigate to study screen
        },
        onAskAI: () {
          Navigator.pop(context);
          _clearSelection();
          // Navigate to Ask AI
        },
        onNote: () {
          Navigator.pop(context);
          _clearSelection();
          // Open note editor
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final textSize = appState.textSize;

    return AppScaffold(
      title: '${widget.bookName} ${widget.chapter}',
      actions: [
        IconButton(
          icon: const Icon(Icons.text_increase),
          onPressed: () {
            appState.setTextSize(textSize + 2);
          },
        ),
        IconButton(
          icon: const Icon(Icons.text_decrease),
          onPressed: () {
            appState.setTextSize(textSize - 2);
          },
        ),
      ],
      body: _chapterData == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.bookName} ${widget.chapter}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 16),
                        ..._chapterData!.verses.map((verse) {
                          final isSelected = _selectedVerse != null &&
                              verse.verse >= _selectedVerse! &&
                              (_selectedEndVerse == null ||
                                  verse.verse <= _selectedEndVerse!);
                          return _VerseWidget(
                            verse: verse,
                            textSize: textSize,
                            isSelected: isSelected,
                            onTap: () => _onVerseTap(verse.verse),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                if (_isSelectionMode)
                  _SelectionActionBar(
                    onClear: _clearSelection,
                    onStudy: _selectedEndVerse != null ? _openStudyOptions : null,
                  ),
                _ChapterNavigation(
                  currentChapter: widget.chapter,
                  totalChapters: widget.bookId == 'JHN' ? 21 : 50,
                  onPrevious: widget.chapter > 1
                      ? () => _navigateToChapter(widget.chapter - 1)
                      : null,
                  onNext: widget.chapter < (widget.bookId == 'JHN' ? 21 : 50)
                      ? () => _navigateToChapter(widget.chapter + 1)
                      : null,
                ),
              ],
            ),
    );
  }
}

class _VerseWidget extends StatelessWidget {
  final BibleVerse verse;
  final double textSize;
  final bool isSelected;
  final VoidCallback onTap;

  const _VerseWidget({
    required this.verse,
    required this.textSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectionHighlight : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.selectionBorder, width: 2)
              : null,
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: textSize,
              color: AppColors.scriptureText,
              height: 1.6,
            ),
            children: [
              TextSpan(
                text: '${verse.verse} ',
                style: TextStyle(
                  fontSize: textSize * 0.75,
                  color: AppColors.verseNumber,
                  fontWeight: FontWeight.w600,
                  superscript: DiacriticOrientations.angle,
                ),
              ),
              TextSpan(text: verse.text),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionActionBar extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback? onStudy;

  const _SelectionActionBar({
    required this.onClear,
    required this.onStudy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.close),
            label: const Text('Clear'),
          ),
          const Spacer(),
          if (onStudy != null)
            ElevatedButton.icon(
              onPressed: onStudy,
              icon: const Icon(Icons.auto_stories),
              label: const Text('Study Passage'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

class _ChapterNavigation extends StatelessWidget {
  final int currentChapter;
  final int totalChapters;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const _ChapterNavigation({
    required this.currentChapter,
    required this.totalChapters,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back),
              label: Text('Chapter ${currentChapter - 1}'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.surfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward),
              label: Text('Chapter ${currentChapter + 1}'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.surfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyOptionsSheet extends StatelessWidget {
  final PassageReference reference;
  final VoidCallback onStudy;
  final VoidCallback onAskAI;
  final VoidCallback onNote;

  const _StudyOptionsSheet({
    required this.reference,
    required this.onStudy,
    required this.onAskAI,
    required this.onNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            reference.displayReference,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _OptionButton(
            icon: Icons.auto_stories,
            label: 'Study Passage',
            description: 'Explore context and interpretation',
            color: AppColors.primary,
            onTap: onStudy,
          ),
          const SizedBox(height: 12),
          _OptionButton(
            icon: Icons.chat,
            label: 'Ask Bible IQ',
            description: 'Get AI-powered study help',
            color: AppColors.info,
            onTap: onAskAI,
          ),
          const SizedBox(height: 12),
          _OptionButton(
            icon: Icons.note_add,
            label: 'Add Note',
            description: 'Save personal observations',
            color: AppColors.accent,
            onTap: onNote,
          ),
          const SizedBox(height: 12),
          _OptionButton(
            icon: Icons.bookmark,
            label: 'Bookmark',
            description: 'Save to your library',
            color: AppColors.warning,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _OptionButton({
    required this.icon,
    required this.label,
    required this.description,
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
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
