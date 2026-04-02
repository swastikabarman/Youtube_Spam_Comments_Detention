import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../services/app_provider.dart';
import '../../widgets/buttons.dart';
import '../../widgets/cards.dart';

class ResultsSection extends StatefulWidget {
  const ResultsSection({super.key});

  @override
  State<ResultsSection> createState() => _ResultsSectionState();
}

class _ResultsSectionState extends State<ResultsSection> {
  final bool _showStats = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        if (!provider.hasCurrentScan) {
          return Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              border: Border.all(color: AppTheme.b1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text(
                'No scan results. Run a scan first!',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.t2,
                ),
              ),
            ),
          );
        }

        final scan = provider.currentScan!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scan.videoTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.t1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        scan.url,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.t3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GhostButton(
                  label: provider.exportToCSV().isNotEmpty ? 'Export CSV' : 'Export',
                  icon: Icons.download,
                  small: true,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('CSV exported successfully!'),
                        duration: Duration(milliseconds: 2000),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Toggle Stats
            if (_showStats) ...[
              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StatCard(
                    label: 'Total Comments',
                    value: scan.totalComments.toString(),
                    valueColor: AppTheme.blue,
                  ),
                  StatCard(
                    label: 'Flagged',
                    value: scan.flaggedCount.toString(),
                    valueColor: AppTheme.red,
                  ),
                  StatCard(
                    label: 'Clean',
                    value: scan.cleanCount.toString(),
                    valueColor: AppTheme.green,
                  ),
                  StatCard(
                    label: 'Spam Rate',
                    value: '${scan.spamRate}%',
                    valueColor: AppTheme.orange,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Category Grid
              const Text(
                'Breakdown by Category',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.t1,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CategoryBadge(
                    category: 'spam',
                    count: scan.categoryBreakdown['spam'] ?? 0,
                    onTap: () => provider.updateFilter('spam'),
                  ),
                  CategoryBadge(
                    category: 'promo',
                    count: scan.categoryBreakdown['promo'] ?? 0,
                    onTap: () => provider.updateFilter('promo'),
                  ),
                  CategoryBadge(
                    category: 'hate',
                    count: scan.categoryBreakdown['hate'] ?? 0,
                    onTap: () => provider.updateFilter('hate'),
                  ),
                  CategoryBadge(
                    category: 'gibberish',
                    count: scan.categoryBreakdown['gibberish'] ?? 0,
                    onTap: () => provider.updateFilter('gibberish'),
                  ),
                  CategoryBadge(
                    category: 'duplicate',
                    count: scan.categoryBreakdown['duplicate'] ?? 0,
                    onTap: () => provider.updateFilter('duplicate'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],

            // Filters
            const Text(
              'Filter Comments',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.t1,
              ),
            ),
            const SizedBox(height: 12),

            // Category Filter
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterButton('All', 'all', provider),
                _buildFilterButton('Spam Bot', 'spam', provider),
                _buildFilterButton('Promo Link', 'promo', provider),
                _buildFilterButton('Hate Speech', 'hate', provider),
                _buildFilterButton('Gibberish', 'gibberish', provider),
                _buildFilterButton('Duplicate', 'duplicate', provider),
              ],
            ),
            const SizedBox(height: 16),

            // Confidence Slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bg3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Confidence Threshold',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.t1,
                        ),
                      ),
                      Text(
                        '${provider.confThreshold}%',
                        style: const TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: provider.confThreshold.toDouble(),
                    min: 0,
                    max: 100,
                    onChanged: (val) =>
                        provider.updateConfidenceThreshold(val.toInt()),
                    activeColor: AppTheme.red,
                    inactiveColor: AppTheme.b2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Comments List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flagged Comments (${provider.filteredComments.length})',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.t1,
                  ),
                ),
                if (provider.filteredComments.isNotEmpty)
                  GhostButton(
                    label: 'Clear Filters',
                    small: true,
                    onPressed: () {
                      provider.updateFilter('all');
                      provider.updateConfidenceThreshold(0);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),

            if (provider.filteredComments.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  border: Border.all(color: AppTheme.b1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'No comments match your filters',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.t2,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.filteredComments.length,
                itemBuilder: (context, index) {
                  return CommentCard(
                    comment: provider.filteredComments[index],
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildFilterButton(String label, String category, AppProvider provider) {
    final isActive = provider.commentFilter == category;
    return GestureDetector(
      onTap: () => provider.updateFilter(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color.fromARGB((0.1 * 255).toInt(), (AppTheme.red.r * 255.0).round().clamp(0, 255), (AppTheme.red.g * 255.0).round().clamp(0, 255), (AppTheme.red.b * 255.0).round().clamp(0, 255)) : AppTheme.bg4,
          border: Border.all(
            color: isActive ? AppTheme.red : AppTheme.b2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? AppTheme.red : AppTheme.t2,
          ),
        ),
      ),
    );
  }
}
