import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../services/app_provider.dart';
import '../../widgets/buttons.dart';
import '../../utils/helpers.dart';

class ScanSection extends StatefulWidget {
  final VoidCallback onScanComplete;

  const ScanSection({super.key, required this.onScanComplete});

  @override
  State<ScanSection> createState() => _ScanSectionState();
}

class _ScanSectionState extends State<ScanSection> {
  late TextEditingController _urlController;
  String? _error;
  int _selectedLimit = 100;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
  }

  void _handleScan(AppProvider provider) async {
    setState(() => _error = null);

    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() => _error = 'Please enter a YouTube video URL.');
      return;
    }

    if (!isValidYoutubeUrl(url)) {
      setState(() => _error = 'Please enter a valid YouTube video URL (watch?v= or youtu.be/).');
      return;
    }

    await provider.performScan(url, _selectedLimit);
    _urlController.clear();
    widget.onScanComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan a YouTube Video',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.t1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter a video URL to analyze its comments for spam',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.t2,
              ),
            ),
            const SizedBox(height: 32),

            // Input Card
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
                  const Row(
                    children: [
                      Icon(Icons.play_circle_outline, color: AppTheme.red, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'YouTube Video URL',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.t1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _urlController,
                    enabled: !provider.isScanning,
                    decoration: InputDecoration(
                      hintText: 'https://youtube.com/watch?v=...',
                      hintStyle: const TextStyle(color: AppTheme.t3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppTheme.b2),
                      ),
                      filled: true,
                      fillColor: AppTheme.bg3,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    style: const TextStyle(color: AppTheme.t1),
                    onChanged: (_) {
                      if (_error != null) {
                        setState(() => _error = null);
                      }
                    },
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.red,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Comment Limit Selection
                  const Text(
                    'Comment Limit',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.t1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [50, 100, 200, 500]
                        .map(
                          (limit) => GestureDetector(
                            onTap: !provider.isScanning
                                ? () => setState(() => _selectedLimit = limit)
                                : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: _selectedLimit == limit
                                    ? Color.fromARGB((0.1 * 255).toInt(), (AppTheme.red.r * 255.0).round().clamp(0, 255), (AppTheme.red.g * 255.0).round().clamp(0, 255), (AppTheme.red.b * 255.0).round().clamp(0, 255))
                                    : AppTheme.bg4,
                                border: Border.all(
                                  color: _selectedLimit == limit
                                      ? AppTheme.red
                                      : AppTheme.b2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$limit comments',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedLimit == limit
                                      ? AppTheme.red
                                      : AppTheme.t2,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Scan Button
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: provider.isScanning ? 'Scanning...' : 'Scan Comments',
                      icon: provider.isScanning
                          ? Icons.hourglass_bottom
                          : Icons.search,
                      isLoading: provider.isScanning,
                      onPressed: provider.isScanning
                          ? () {}
                          : () => _handleScan(provider),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Info Cards
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.bg2,
                border: Border.all(color: AppTheme.b1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    '⚡',
                    '~4 second scan',
                    'Fast AI analysis on your video',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    '💬',
                    'Up to 500 comments',
                    'Analyzes public comments from the video',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    '🔒',
                    'No sign-up required',
                    'Start scanning immediately',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    '👁️',
                    'No data stored',
                    'Your data is never saved',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String emoji, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.t1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.t3,
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
    _urlController.dispose();
    super.dispose();
  }
}
