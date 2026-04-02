/// Constants and Configuration
class AppConstants {
  // Category Configuration
  static const Map<String, Map<String, String>> categories = {
    'spam': {'label': 'Spam Bot', 'icon': '🤖'},
    'promo': {'label': 'Promo Link', 'icon': '🔗'},
    'hate': {'label': 'Hate Speech', 'icon': '🚫'},
    'gibberish': {'label': 'Gibberish', 'icon': '🗒️'},
    'duplicate': {'label': 'Duplicate', 'icon': '📋'},
    'clean': {'label': 'Clean', 'icon': '✓'},
  };

  // Mock Data Pools
  static const List<String> spamPool = [
    'Sub 4 sub?? → @FakeChannel99',
    'Check my channel for FREE tutorials!',
    'Follow back guaranteed → @SpamAccount',
    'Nice vid! Subscribe 2 subscribe?',
    'Visit my profile for exclusive content!',
    'Drop a sub and I sub back instantly!',
  ];

  static const List<String> promoPool = [
    '🔥 FREE Bitcoin → bit.ly/crypto2025',
    'Earn \$500/day clicking link in bio',
    '💰 Make money online → t.me/earnfast',
    'Free NFTs at bit.ly/freenft2025',
    'I made \$1000 using this → tinyurl.com/hack',
    '🚨 Click NOW to win iPhone 15 → link.xyz',
  ];

  static const List<String> hatePool = [
    'This video is absolute garbage',
    'worst content I have ever seen, delete it',
    'you should just quit making videos',
    'nobody wants to watch this trash',
    'this is completely useless content',
  ];

  static const List<String> gibberishPool = [
    'aaaaaa bbbbb ccccc 123',
    '😂😂😂😂😂😂😂😂😂😂😂',
    'lol lol lol lol lol lol lol',
    'asdfghjkl qwerty zxcvbnm',
    '!!!!!!! ??????? .......',
    'xD xD xD xD xD xD xD',
    '🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥',
  ];

  static const List<String> duplicatePool = [
    'First!',
    'Great video!',
    'Love this so much!',
    'Amazing work, keep it up!',
    'This is so helpful thank you!',
  ];

  static const List<String> cleanPool = [
    'Really enjoyed this tutorial — the section at 3:24 finally made it click for me.',
    'Been following your channel for 2 years, this is honestly one of your best videos.',
    'Tried this method yesterday and it worked perfectly on the first attempt. Thank you!',
    'The explanation was clear and easy to follow, no wasted time. More like this please.',
    'Came back to rewatch this for the third time, it is just that good.',
    'Finally a video that gets to the point without 10 minutes of intro.',
    'This answered a question I have had for months. Genuinely helpful content.',
    'Subscribed after watching this. Exactly the quality I was looking for.',
    'I shared this with my entire team — everyone found it useful.',
    'The depth of research here is impressive. Clearly a lot of work went into this.',
  ];

  static const List<String> users = [
    '@TechFan2024',
    '@CryptoKing99',
    '@MusicLover',
    '@RandomUser42',
    '@PromoBot_01',
    '@SpamAccount',
    '@NormalViewer',
    '@HelpfulPerson',
    '@GadgetFreak',
    '@LearnDaily',
    '@FreeMoneyXX',
    '@SubBot_123',
    '@LegitUser',
    '@ContentWatcher',
    '@SpamSpam99',
  ];

  static const Map<String, List<String>> titles = {
    'sus': [
      'FREE Crypto Giveaway LIVE 2025',
      'Earn \$500/Day Full Tutorial',
      'BITCOIN Signal Subscribe NOW!'
    ],
    'safe': [
      'How to Cook Perfect Pasta',
      'Guitar for Beginners Full Course',
      'Amazing Life Hacks You Need'
    ],
  };

  // Statistics
  static const String accuracy = '96.2%';
  static const String totalCommentsAnalyzed = '12M+';
  static const String spamCategories = '5';
  static const String avgScanTime = '<4s';

  // Seed History for Mock Data
  static const List<Map<String, dynamic>> seedHistory = [
    {
      'id': 1,
      'title': '10 Life Hacks You Must Try',
      'url': 'youtube.com/watch?v=abc123',
      'date': '2025-03-15 11:30',
      'total': 412,
      'flagged': 87,
      'spamRate': 21
    },
    {
      'id': 2,
      'title': 'FREE Bitcoin Giveaway LIVE',
      'url': 'youtube.com/watch?v=xyz789',
      'date': '2025-03-14 09:15',
      'total': 1840,
      'flagged': 963,
      'spamRate': 52
    },
    {
      'id': 3,
      'title': 'Cooking Pasta from Scratch',
      'url': 'youtube.com/watch?v=def456',
      'date': '2025-03-13 18:44',
      'total': 204,
      'flagged': 8,
      'spamRate': 4
    },
    {
      'id': 4,
      'title': 'CRYPTO SIGNALS 2025 (LIVE)',
      'url': 'youtube.com/watch?v=ghi012',
      'date': '2025-03-12 14:20',
      'total': 2100,
      'flagged': 1470,
      'spamRate': 70
    },
    {
      'id': 5,
      'title': 'How to Learn Guitar in 30 Days',
      'url': 'youtube.com/watch?v=jkl345',
      'date': '2025-03-11 20:08',
      'total': 389,
      'flagged': 31,
      'spamRate': 8
    },
  ];
}
