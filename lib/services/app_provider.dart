import 'package:flutter/material.dart';
import 'bert_detector.dart';
import 'youtube_api.dart';
import '../config.dart';
import '../models/models.dart';

class AppProvider extends ChangeNotifier {
  bool isScanning = false;

  // ✅ FIXED TYPES
  List<Comment> comments = [];
  int totalComments = 0;
  int fakeComments = 0;

  // 🔥 History now stores ScanResult
  List<ScanResult> scanHistory = [];

  String commentFilter = 'all';
  int confThreshold = 0;

  final YouTubeAPI youtubeApi = YouTubeAPI(youtubeApiKey);
  final BERTDetector detector = BERTDetector();

  ScanResult? currentScan;

  // ✅ FILTERED COMMENTS
  List<Comment> get filteredComments {
    if (currentScan == null) return [];

    if (commentFilter == 'all') {
      return currentScan!.comments;
    }

    return currentScan!.comments
        .where((c) => c.category == commentFilter)
        .toList();
  }

  bool get hasCurrentScan => currentScan != null;

  int get historyCount => scanHistory.length;

  Future<void> performScan(String url, int limit) async {
    isScanning = true;
    notifyListeners();

    try {
      String videoId = _extractVideoId(url);

      final fetchedComments = await youtubeApi.getComments(videoId);

      List<Comment> results = [];
      int fakeCount = 0;

      for (var c in fetchedComments.take(limit)) {
        var res = await detector.predict(c.text);

        if (res.isFake) fakeCount++;

        results.add(
          Comment(
            text: c.text,
            author: c.author,
            confidence: res.confidence,
            isFake: res.isFake,
            category: res.isFake ? 'spam' : 'clean',
            time: "now",
            likes: 0,
          ),
        );
      }

      comments = results;
      totalComments = results.length;
      fakeComments = fakeCount;

      // ✅ CREATE SCAN RESULT OBJECT
      currentScan = ScanResult(
        videoTitle: "YouTube Video",
        url: url,
        totalComments: results.length,
        flaggedCount: fakeCount,
        cleanCount: results.length - fakeCount,
        spamRate: results.isEmpty
            ? 0
            : ((fakeCount / results.length) * 100).toInt(),
        categoryBreakdown: {
          "spam": fakeCount,
          "clean": results.length - fakeCount,
        },
        comments: results,
      );

      // ✅ SAVE TO HISTORY
      scanHistory.insert(0, currentScan!);

    } catch (e) {
      print("Error: $e");
    }

    isScanning = false;
    notifyListeners();
  }

  void updateFilter(String filter) {
    commentFilter = filter;
    notifyListeners();
  }

  void updateConfidenceThreshold(int val) {
    confThreshold = val;
    notifyListeners();
  }

  // ✅ FIXED CSV EXPORT
  String exportToCSV() {
    return comments
        .map((c) => "${c.text},${c.author},${c.category}")
        .join("\n");
  }

  String _extractVideoId(String url) {
    if (url.contains("v=")) {
      return url.split("v=")[1].split("&")[0];
    } else if (url.contains("youtu.be/")) {
      return url.split("youtu.be/")[1];
    }
    return url;
  }
}