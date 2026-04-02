import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/buttons.dart';

class LandingScreen extends StatefulWidget {
  final VoidCallback onLaunchApp;

  const LandingScreen({super.key, required this.onLaunchApp});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _error;
  bool _showMenu = false;

  void _handleScan() {
    setState(() {
      _error = null;
    });

    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() => _error = 'Please enter a YouTube video URL.');
      return;
    }

    widget.onLaunchApp();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppTheme.bg0,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppTheme.b1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.bg3,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.b2),
                        ),
                        child: const Center(
                          child: Icon(Icons.shield, color: AppTheme.red, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'CommentGuard',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.t1,
                        ),
                      ),
                    ],
                  ),

                  // Right side
                  if (!isMobile)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'How It Works',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.t2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Features',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.t2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        PrimaryButton(
                          label: 'Launch App',
                          onPressed: widget.onLaunchApp,
                          icon: Icons.arrow_forward,
                          small: true,
                        ),
                      ],
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: AppTheme.t1,
                      onPressed: () => setState(() => _showMenu = !_showMenu),
                    ),
                ],
              ),
            ),

            // Mobile Menu
            if (isMobile && _showMenu)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppTheme.b1)),
                ),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'How It Works',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.t2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Features',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.t2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: 'Launch App',
                        onPressed: widget.onLaunchApp,
                        icon: Icons.rocket_launch,
                      ),
                    ),
                  ],
                ),
              ),

            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.redSoft,
                      border: Border.all(color: AppTheme.redBorder),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppTheme.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'AI-Powered · 96.2% Accuracy · 5 Spam Categories',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Stop Spam & Bot Comments\nBefore They Poison\nYour Community',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: isMobile ? 28 : 42,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.t1,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Paste any YouTube video URL and get a full spam analysis in seconds. CommentGuard classifies every comment — spam bots, promo links, hate speech, gibberish, and duplicate floods — so you can moderate with confidence.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.t2,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Scan Box
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.bgCard,
                      border: Border.all(color: AppTheme.b2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.play_circle_outline, color: AppTheme.red, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'YouTube Video URL',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.t1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _urlController,
                                decoration: InputDecoration(
                                  hintText: 'https://youtube.com/watch?v=...',
                                  hintStyle: const TextStyle(color: AppTheme.t3),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: AppTheme.b2),
                                  ),
                                  filled: true,
                                  fillColor: AppTheme.bg3,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                style: const TextStyle(color: AppTheme.t1),
                                onChanged: (_) {
                                  if (_error != null) {
                                    setState(() => _error = null);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            PrimaryButton(
                              label: 'Scan',
                              icon: Icons.search,
                              onPressed: _handleScan,
                            ),
                          ],
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _error!,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.red,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStat('96.2%', 'Accuracy'),
                      Container(width: 1, height: 40, color: AppTheme.b1),
                      _buildStat('12M+', 'Comments Analyzed'),
                      Container(width: 1, height: 40, color: AppTheme.b1),
                      _buildStat('5', 'Spam Categories'),
                      Container(width: 1, height: 40, color: AppTheme.b1),
                      _buildStat('<4s', 'Avg Scan Time'),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),

            // Features Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                children: [
                  const Text(
                    'FEATURES',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.red,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Everything you need to moderate\nYouTube comments at scale',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.t1,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GridView.count(
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildFeatureCard(
                        icon: Icons.local_offer,
                        title: '5 Spam Categories',
                        desc: 'Detects Spam Bots, Promo Links, Hate Speech, Gibberish floods, and Duplicate copy-paste attacks.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.percent,
                        title: 'Confidence Scores',
                        desc: 'Every flagged comment gets a 0–100% confidence score so you control the sensitivity threshold.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.person_off,
                        title: 'Repeat Offender Detection',
                        desc: 'See which accounts are posting the most spam — repeat spammers surface instantly.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.layers,
                        title: 'Bulk Video Scan',
                        desc: 'Scan up to 10 YouTube videos simultaneously and compare spam rates across your channel.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.filter_alt,
                        title: 'Paste & Classify Tool',
                        desc: 'No URL? Paste raw comment text directly and get instant spam classification per line.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.download,
                        title: 'CSV Export',
                        desc: 'Download all flagged comments as a structured CSV — ready for bulk moderation.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // CTA Strip
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                border: Border.all(color: AppTheme.b2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const Text(
                    'Ready to clean up your comment section?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.t1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Start your first scan in under 10 seconds. No account needed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.t2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Launch CommentGuard',
                    icon: Icons.rocket_launch,
                    onPressed: widget.onLaunchApp,
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppTheme.b1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppTheme.bg3,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.b2),
                            ),
                            child: const Center(
                              child: Icon(Icons.shield, color: AppTheme.red, size: 16),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'CommentGuard',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.t1,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '© 2025 CommentGuard',
                        style: TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppTheme.red,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.t2,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String desc}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: Border.all(color: AppTheme.b1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.red, size: 24),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.t1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppTheme.t2,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
