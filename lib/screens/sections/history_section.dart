import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../services/app_provider.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan History',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.t1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All your previous scans (${provider.scanHistory.length} total)',
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.t2,
              ),
            ),
            const SizedBox(height: 24),

            if (provider.scanHistory.isEmpty)
              Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  border: Border.all(color: AppTheme.b1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'No scan history yet',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
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
                itemCount: provider.scanHistory.length,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + Spam %
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.videoTitle, // ✅ FIXED
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.t1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // URL
                        Text(
                          item.url, // ✅ OK
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.t3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Comments',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.t3,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.totalComments.toString(), // ✅ FIXED
                                  style: const TextStyle(
                                    fontFamily: 'IBMPlexMono',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.t1,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Flagged',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.t3,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.flaggedCount.toString(), // ✅ FIXED
                                  style: const TextStyle(
                                    fontFamily: 'IBMPlexMono',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.red,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Scanned',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.t3,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Now', // ✅ TEMP FIX (no date field)
                                  style: TextStyle(
                                    fontFamily: 'IBMPlexMono',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.t2,
                                  ),
                                ),
                              ],
                            ),
                          ],
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