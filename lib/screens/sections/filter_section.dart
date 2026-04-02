import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/buttons.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late TextEditingController _commentController;
  List<Map<String, dynamic>> _results = [];

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  void _classifyComments() {
    final text = _commentController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please paste some comments')),
      );
      return;
    }

    final lines = text.split('\n').where((l) => l.isNotEmpty).toList();
    setState(() {
      _results = lines
          .map((line) => {
                'text': line,
                'category': _mockClassify(line),
                'confidence': _mockConfidence(line),
              })
          .toList();
    });
  }

  String _mockClassify(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('sub') || lower.contains('subscribe')) {
      return 'spam';
    }
    if (lower.contains('free') || lower.contains('click')) {
      return 'promo';
    }
    if (lower.contains('hate') || lower.contains('trash')) {
      return 'hate';
    }
    if (lower.contains('lol') || lower.contains('xd')) {
      return 'gibberish';
    }
    if (lower.contains('great') ||
        lower.contains('good') ||
        lower.contains('love')) {
      return 'clean';
    }
    return 'clean';
  }

  int _mockConfidence(String text) {
    return 75 + (text.hashCode % 20);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comment Filter Tool',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.t1,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Paste raw comments and classify them instantly',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.t2,
          ),
        ),
        const SizedBox(height: 32),

        // Input Area
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            border: Border.all(color: AppTheme.b2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paste Comments (one per line)',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.t1,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _commentController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText:
                      'Check my channel for tutorials!\nSub 4 sub??\nGreat video!\n...',
                  hintStyle: const TextStyle(color: AppTheme.t3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppTheme.b2),
                  ),
                  filled: true,
                  fillColor: AppTheme.bg3,
                ),
                style: const TextStyle(color: AppTheme.t1),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Classify Comments',
                  icon: Icons.auto_awesome,
                  onPressed: _classifyComments,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Results
        if (_results.isNotEmpty) ...[
          const Text(
            'Classification Results',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.t1,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final result = _results[index];
              final category = result['category'];
              final color = _getCategoryColor(category);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  border: Border.all(color: Color.fromARGB((0.2 * 255).toInt(), (color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255))),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB((0.1 * 255).toInt(), (color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255)),
                        border: Border.all(color: Color.fromARGB((0.3 * 255).toInt(), (color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255))),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['text'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.t1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Confidence: ${result['confidence']}%',
                            style: const TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.t3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'spam':
        return AppTheme.red;
      case 'promo':
        return AppTheme.orange;
      case 'hate':
        return AppTheme.yellow;
      case 'gibberish':
        return AppTheme.blue;
      case 'duplicate':
        return AppTheme.purple;
      case 'clean':
        return AppTheme.green;
      default:
        return AppTheme.t2;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
