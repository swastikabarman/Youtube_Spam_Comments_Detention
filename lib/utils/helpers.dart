import 'dart:math';

/// Helper Utility Functions

// URL Validation
bool isValidYoutubeUrl(String url) {
  if (url.isEmpty) return false;
  
  final youtubeUrlPattern = RegExp(
    r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)+(.com)?\/watch(\?v=|\/)',
    caseSensitive: false,
  );
  
  return youtubeUrlPattern.hasMatch(url) || 
         url.contains('watch?v=') || 
         url.contains('youtu.be/');
}

// Random utilities
int randomInt(int min, int max) {
  return min + Random().nextInt(max - min + 1);
}

double randomFloat(double min, double max) {
  return min + Random().nextDouble() * (max - min);
}

// Number formatting
String formatNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M+';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  }
  return number.toString();
}

// CSV Export
String escapeCSV(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}

// Colors for categories
String getCategoryLabel(String category) {
  switch (category.toLowerCase()) {
    case 'spam':
      return 'Spam Bot';
    case 'promo':
      return 'Promo Link';
    case 'hate':
      return 'Hate Speech';
    case 'gibberish':
      return 'Gibberish';
    case 'duplicate':
      return 'Duplicate';
    case 'clean':
      return 'Clean';
    default:
      return category;
  }
}

String getCategoryEmoji(String category) {
  switch (category.toLowerCase()) {
    case 'spam':
      return '🤖';
    case 'promo':
      return '🔗';
    case 'hate':
      return '🚫';
    case 'gibberish':
      return '🗒️';
    case 'duplicate':
      return '📋';
    case 'clean':
      return '✓';
    default:
      return '•';
  }
}
