import 'package:flutter/material.dart';
import '../services/youtube_api.dart';
import '../services/bert_detector.dart';
import '../models/comment_model.dart';
import '../config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _videoIdController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();

  final BERTDetector _detector = BERTDetector();
  final YouTubeAPI _youtubeApi = YouTubeAPI(youtubeApiKey);

  List<Comment> _comments = [];
  List<DetectionResult> _results = [];
  bool _isAnalyzing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🛡️ Comment Detector'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🎥 Video ID Input
            Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _videoIdController,
                      decoration: InputDecoration(
                        labelText: 'YouTube Video ID',
                        hintText: 'dQw4w9WgXcQ',
                        prefixIcon:
                            Icon(Icons.video_library, color: Colors.red),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            _videoIdController.text =
                                'dQw4w9WgXcQ'; // Test video
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _isAnalyzing ? null : _analyzeComments,
                      icon: Icon(Icons.search),
                      label: Text(_isAnalyzing
                          ? 'Analyzing...'
                          : '🔍 Analyze Comments'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // 📊 Results
            if (_comments.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_comments.length} comments analyzed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                        '${_results.where((r) => r.isFake).length} fakes found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
              ),

            SizedBox(height: 20),

            // 📝 Comments List
            ..._comments.asMap().entries.map((entry) {
              int index = entry.key;
              Comment comment = entry.value;
              DetectionResult result = _results.length > index
                  ? _results[index]
                  : DetectionResult(
                      isFake: false,
                      confidence: 0,
                      fakeProbability: 0,
                      sentiment: 'Neutral');

              return Card(
                margin: EdgeInsets.only(bottom: 12),
                elevation: 4,
                color: result.isFake ? Colors.red[50] : Colors.green[50],
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: result.isFake ? Colors.red : Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      result.isFake ? Icons.warning : Icons.verified,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    comment.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.author,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                              '${(result.confidence * 100).toStringAsFixed(0)}% confidence'),
                          SizedBox(width: 12),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(result.sentiment,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${(result.fakeProbability * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          result.isFake ? Colors.red[700] : Colors.green[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> _analyzeComments() async {
    if (_videoIdController.text.isEmpty) return;

    setState(() => _isAnalyzing = true);

    try {
      // Fetch comments
      _comments = await _youtubeApi.getComments(_videoIdController.text);

      // Analyze each comment
      _results = [];
      for (var comment in _comments) {
        var result = await _detector.predict(comment.text);
        _results.add(result);
      }

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() => _isAnalyzing = false);
  }
}
