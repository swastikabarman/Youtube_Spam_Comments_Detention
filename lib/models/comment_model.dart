class Comment {
  final String id;
  final String text;
  final String author;
  final String publishedAt;

  Comment({
    required this.id,
    required this.text,
    required this.author,
    required this.publishedAt,
  });
}

class DetectionResult {
  final bool isFake;
  final double confidence;
  final double fakeProbability;
  final String sentiment;

  DetectionResult({
    required this.isFake,
    required this.confidence,
    required this.fakeProbability,
    required this.sentiment,
  });
}