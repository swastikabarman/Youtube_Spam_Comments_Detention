class Comment {
  final String text;
  final String author;
  final double confidence;
  final bool isFake;
  final String category;
  final String time;
  final int likes;

  Comment({
    required this.text,
    required this.author,
    required this.confidence,
    required this.isFake,
    required this.category,
    required this.time,
    required this.likes,
  });
}

class ScanResult {
  final String videoTitle;
  final String url;
  final int totalComments;
  final int flaggedCount;
  final int cleanCount;
  final int spamRate;
  final Map<String, int> categoryBreakdown;
  final List<Comment> comments;

  ScanResult({
    required this.videoTitle,
    required this.url,
    required this.totalComments,
    required this.flaggedCount,
    required this.cleanCount,
    required this.spamRate,
    required this.categoryBreakdown,
    required this.comments,
  });
}