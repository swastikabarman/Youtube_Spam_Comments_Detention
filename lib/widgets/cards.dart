import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

/// Reusable Card Widgets

class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onTap;

  const CommentCard({
    super.key,
    required this.comment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = AppTheme.getCategoryColor(comment.category);
    final categoryLabel = getCategoryLabel(comment.category);
    final categoryEmoji = getCategoryEmoji(comment.category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          border: Border.all(
            color: comment.category == 'clean' ? AppTheme.b1 : Color.fromARGB((0.2 * 255).toInt(), (categoryColor.r * 255.0).round().clamp(0, 255), (categoryColor.g * 255.0).round().clamp(0, 255), (categoryColor.b * 255.0).round().clamp(0, 255)),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Author + Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.bg3,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppTheme.b2),
                      ),
                      child: Center(
                        child: Text(
                          comment.author.substring(0, 1),
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.t2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.author,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.t1,
                          ),
                        ),
                        Text(
                          comment.time,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.t3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color.fromARGB((0.1 * 255).toInt(), (categoryColor.r * 255.0).round().clamp(0, 255), (categoryColor.g * 255.0).round().clamp(0, 255), (categoryColor.b * 255.0).round().clamp(0, 255)),
                    border: Border.all(color: Color.fromARGB((0.3 * 255).toInt(), (categoryColor.r * 255.0).round().clamp(0, 255), (categoryColor.g * 255.0).round().clamp(0, 255), (categoryColor.b * 255.0).round().clamp(0, 255))),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        categoryEmoji,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        categoryLabel,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: categoryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Comment Text
            Text(
              comment.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.t1,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // Footer: Confidence + Likes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Confidence bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Confidence: ',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.t3,
                            ),
                          ),
                          Text(
                            '${comment.confidence}%',
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: categoryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppTheme.bg4,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: comment.confidence / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: categoryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Likes
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_outline,
                      size: 14,
                      color: AppTheme.t3,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      comment.likes.toString(),
                      style: const TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.t2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: Border.all(color: AppTheme.b1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppTheme.t2, size: 20),
            const SizedBox(height: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.t3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: valueColor ?? AppTheme.t1,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String category;
  final int count;
  final VoidCallback? onTap;

  const CategoryBadge({
    super.key,
    required this.category,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getCategoryColor(category);
    final label = getCategoryLabel(category);
    final emoji = getCategoryEmoji(category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB((0.1 * 255).toInt(), (color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255)),
          border: Border.all(color: Color.fromARGB((0.3 * 255).toInt(), (color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255))),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
