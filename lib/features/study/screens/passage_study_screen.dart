import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';

class PassageStudyScreen extends StatefulWidget {
  final String reference;

  const PassageStudyScreen({
    super.key,
    required this.reference,
  });

  @override
  State<PassageStudyScreen> createState() => _PassageStudyScreenState();
}

class _PassageStudyScreenState extends State<PassageStudyScreen> {
  int _selectedSection = 0;

  final List<StudySection> _sections = [
    StudySection(
      title: 'Overview',
      icon: Icons.info_outline,
    ),
    StudySection(
      title: 'Context',
      icon: Icons.location_on_outlined,
    ),
    StudySection(
      title: 'Background',
      icon: Icons.history_edu,
    ),
    StudySection(
      title: 'Observation',
      icon: Icons.visibility,
    ),
    StudySection(
      title: 'Interpretation',
      icon: Icons.lightbulb_outline,
    ),
    StudySection(
      title: 'Cross-References',
      icon: Icons.link,
    ),
    StudySection(
      title: 'Theology',
      icon: Icons.account_balance,
    ),
    StudySection(
      title: 'Application',
      icon: Icons.check_circle_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.reference,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Section navigation
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    border: Border(
                      right: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: _sections.length,
                    itemBuilder: (context, index) {
                      final section = _sections[index];
                      final isSelected = _selectedSection == index;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSection = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: isSelected ? AppColors.primary : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                section.icon,
                                size: 24,
                                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                section.title,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Content area
                Expanded(
                  child: _buildSectionContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_selectedSection) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildContext();
      case 2:
        return _buildBackground();
      case 3:
        return _buildObservation();
      case 4:
        return _buildInterpretation();
      case 5:
        return _buildCrossReferences();
      case 6:
        return _buildTheology();
      case 7:
        return _buildApplication();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passage Overview',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Main Subject',
            content: 'This passage introduces the foundational truth about Jesus Christ as the eternal Word of God who became flesh to dwell among humanity.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Central Message',
            content: 'Jesus Christ is the divine Word, co-eternal with God the Father, who took on human nature to reveal God\'s glory and bring grace and truth to humanity.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Place in the Book',
            content: 'This is the prologue to John\'s Gospel, setting the theological foundation for the entire book. It precedes the narrative of John the Baptist\'s testimony and Jesus\' public ministry.',
          ),
        ],
      ),
    );
  }

  Widget _buildContext() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Immediate Literary Context',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'What Precedes',
            content: 'This is the opening passage of the Gospel. There is no preceding text in this book, but it connects to the Genesis creation account.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'What Follows',
            content: 'The passage transitions to John the Baptist\'s testimony about Jesus, providing the first witness to the identity described in the prologue.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Literary Structure',
            content: 'The prologue follows a chiastic structure, with key themes introduced, developed, and then revisited with deeper meaning.',
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book Background',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Authorship',
            content: 'Traditionally attributed to John the apostle, one of Jesus\' inner circle. The author identifies himself as "the disciple whom Jesus loved."',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Date and Setting',
            content: 'Likely written between AD 85-95, probably from Ephesus. Written to a community of believers facing questions about Jesus\' identity.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Purpose',
            content: 'John states his purpose explicitly: "These are written that you may believe that Jesus is the Messiah, the Son of God, and that by believing you may have life in his name." (John 20:31)',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Genre',
            content: 'Theological biography (Gospel) that combines narrative with extended discourses and theological reflection.',
          ),
        ],
      ),
    );
  }

  Widget _buildObservation() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Observation and Literary Analysis',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ObservationItem(
            label: 'Repeated Words',
            content: '"Word" (Logos), "life", "light", "believe", "witness" - these key terms form the theological framework.',
          ),
          const SizedBox(height: 12),
          _ObservationItem(
            label: 'Contrasts',
            content: 'Light vs. darkness, receiving vs. rejecting, born of God vs. born of flesh.',
          ),
          const SizedBox(height: 12),
          _ObservationItem(
            label: 'Key Claims',
            content: 'The Word was God, the Word became flesh, full of grace and truth.',
          ),
          const SizedBox(height: 12),
          _ObservationItem(
            label: 'Structure',
            content: 'The passage moves from eternity past (v. 1-2) to creation (v. 3) to incarnation (v. 14) to revelation (v. 18).',
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretation() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interpretation',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Meaning in Context',
            content: 'John identifies Jesus as the divine Word who existed before creation and through whom all things were made. This establishes Jesus\' deity as the foundation of the Gospel.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'The Incarnation',
            content: '"The Word became flesh" (v. 14) is the central claim - God took on human nature while remaining fully divine. This is the mystery of the incarnation.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Grace and Truth',
            content: 'Jesus brings the fullness of grace (unmerited favor) and truth (divine reality), surpassing the law given through Moses.',
          ),
        ],
      ),
    );
  }

  Widget _buildCrossReferences() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cross-References',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _CrossReferenceItem(
            reference: 'Genesis 1:1',
            relevance: 'John echoes "In the beginning" to connect Jesus with creation.',
          ),
          const SizedBox(height: 12),
          _CrossReferenceItem(
            reference: 'Colossians 1:16-17',
            relevance: 'Paul affirms that all things were created through Christ.',
          ),
          const SizedBox(height: 12),
          _CrossReferenceItem(
            reference: 'Hebrews 1:1-3',
            relevance: 'The Son is the radiance of God\'s glory and sustains all things.',
          ),
          const SizedBox(height: 12),
          _CrossReferenceItem(
            reference: 'Revelation 19:13',
            relevance: 'The returning Christ is called "the Word of God."',
          ),
        ],
      ),
    );
  }

  Widget _buildTheology() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theological Significance',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Christology',
            content: 'This passage is foundational for understanding the person of Christ - fully God and fully man, one person with two natures.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Trinity',
            content: 'The Word "was with God" (distinct person) and "was God" (divine nature) - early testimony to the Trinity.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Revelation',
            content: 'God has revealed Himself definitively in Jesus Christ. No one has seen God except the Son who makes Him known.',
          ),
          const SizedBox(height: 16),
          _ContentBlock(
            title: 'Salvation',
            content: 'Life comes through believing in Jesus\' name. This salvation is a gift of grace, not earned by human effort.',
          ),
        ],
      ),
    );
  }

  Widget _buildApplication() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Practical Application',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          _ApplicationItem(
            title: 'Trust in Jesus',
            content: 'Since Jesus is the eternal Word of God, we can trust Him completely with our lives.',
          ),
          const SizedBox(height: 12),
          _ApplicationItem(
            title: 'Receive God\'s Grace',
            content: 'We receive grace and truth through Christ, not by our own merit or religious observance.',
          ),
          const SizedBox(height: 12),
          _ApplicationItem(
            title: 'Know God',
            content: 'To know God, we must look to Jesus. He is the definitive revelation of the Father.',
          ),
          const SizedBox(height: 12),
          _ApplicationItem(
            title: 'Live as Children of God',
            content: 'Those who receive Christ are given the right to become children of God - this should shape our identity and how we live.',
          ),
          const SizedBox(height: 24),
          Card(
            color: AppColors.warning.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: AppColors.warning),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Application must flow from the passage\'s meaning. Avoid taking verses out of context to support personal agendas.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }
}

class StudySection {
  final String title;
  final IconData icon;

  StudySection({
    required this.title,
    required this.icon,
  });
}

class _ContentBlock extends StatelessWidget {
  final String title;
  final String content;

  const _ContentBlock({
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

class _ObservationItem extends StatelessWidget {
  final String label;
  final String content;

  const _ObservationItem({
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _CrossReferenceItem extends StatelessWidget {
  final String reference;
  final String relevance;

  const _CrossReferenceItem({
    required this.reference,
    required this.relevance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reference,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              relevance,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApplicationItem extends StatelessWidget {
  final String title;
  final String content;

  const _ApplicationItem({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.success, width: 4),
        ),
        color: AppColors.success.withOpacity(0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
