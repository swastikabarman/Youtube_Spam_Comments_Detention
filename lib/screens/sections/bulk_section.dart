import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/buttons.dart';

class BulkSection extends StatefulWidget {
  const BulkSection({super.key});

  @override
  State<BulkSection> createState() => _BulkSectionState();
}

class _BulkSectionState extends State<BulkSection> {
  final List<TextEditingController> _urlControllers =
      List.generate(3, (_) => TextEditingController());
  final List<String> _urls = [];

  void _addUrl() {
    if (_urls.length < 10) {
      setState(() => _urls.add(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bulk Video Scan',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.t1,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Scan up to 10 YouTube videos at once and compare spam rates',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.t2,
          ),
        ),
        const SizedBox(height: 32),

        // URL Inputs
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
                'Video URLs',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.t1,
                ),
              ),
              const SizedBox(height: 16),
              ...[0, 1, 2].map((i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: _urlControllers[i],
                    decoration: InputDecoration(
                      hintText: 'https://youtube.com/watch?v=...',
                      hintStyle: const TextStyle(color: AppTheme.t3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppTheme.b2),
                      ),
                      filled: true,
                      fillColor: AppTheme.bg3,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        color: AppTheme.t3,
                        onPressed: () {},
                      ),
                    ),
                    style: const TextStyle(color: AppTheme.t1),
                  ),
                );
              }),
              const SizedBox(height: 16),
              if (_urls.length < 10)
                TextButton.icon(
                  onPressed: _addUrl,
                  icon: const Icon(Icons.add),
                  label: const Text('Add another URL'),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Scan All Videos',
                  icon: Icons.search,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Starting bulk scan...'),
                        duration: Duration(milliseconds: 2000),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in _urlControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
