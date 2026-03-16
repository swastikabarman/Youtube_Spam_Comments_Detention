import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';

class YouTubeAPI {
  static const String baseUrl = 'https://www.googleapis.com/youtube/v3';
  final String apiKey;

  YouTubeAPI(this.apiKey);

  Future<List<Comment>> getComments(String videoId) async {
    final url = Uri.parse('$baseUrl/commentThreads').replace(queryParameters: {
      'part': 'snippet',
      'videoId': videoId,
      'maxResults': '50',
      'key': apiKey,
      'order': 'time'
    });

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        print('API Error: ${response.statusCode}');
        return [];
      }

      final data = json.decode(response.body);
      List<Comment> comments = [];

      for (var item in (data['items'] ?? [])) {
  final snippet = item['snippet']['topLevelComment']['snippet'];
    comments.add(Comment(
    id: item['id'] ?? '',
    text: snippet['textDisplay'] ?? '',
    author: snippet['authorDisplayName'] ?? 'Unknown',
    publishedAt: snippet['publishedAt'] ?? '',
    ));
  }
      print('✅ Fetched ${comments.length} comments');
      return comments;
    } catch (e) {
      print('API Error: $e');
      return [];
    }
  }
}
