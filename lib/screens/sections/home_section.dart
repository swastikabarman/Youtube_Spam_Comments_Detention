import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../services/app_provider.dart';
import '../../widgets/cards.dart';
import '../../utils/helpers.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            const Text(
              'Welcome back! 👋',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.t1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Here\'s your spam detection overview',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.t2,
              ),
            ),
            const SizedBox(height: 32),

            // Stats Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StatCard(
                  label: 'Total Scans',
                  value: provider.historyCount.toString(),
                  valueColor: AppTheme.red,
                  icon: Icons.search,
                ),
                StatCard(
                  label: 'Comments Analyzed',
                  value: provider.hasCurrentScan
                      ? formatNumber(provider.currentScan!.totalComments)
                      : '0',
                  valueColor: AppTheme.blue,
                  icon: Icons.comment,
                ),
                StatCard(
                  label: 'Flagged Comments',
                  value: provider.hasCurrentScan
                      ? formatNumber(provider.currentScan!.flaggedCount)
                      : '0',
                  valueColor: AppTheme.orange,
                  icon: Icons.warning,
                ),
                const StatCard(
                  label: 'Accuracy',
                  value: '96.2%',
                  valueColor: AppTheme.green,
                  icon: Icons.trending_up,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recent Scans
            const Text(
              'Recent Scans',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.t1,
              ),
            ),
            const SizedBox(height: 16),

            if (provider.scanHistory.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  border: Border.all(color: AppTheme.b1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'No scans yet. Start by running your first scan!',
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
                itemCount: provider.scanHistory.take(5).length,
                itemBuilder: (context, index) {
                  final item = provider.scanHistory[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.bgCard,
                      border: Border.all(color: AppTheme.b1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.videoTitle, // ✅ FIXED
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.t1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.totalComments} comments • ${item.flaggedCount} flagged', // ✅ FIXED
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
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.redSoft,
                            border: Border.all(color: AppTheme.redBorder),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${item.spamRate}%', // ✅ OK
                            style: const TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}