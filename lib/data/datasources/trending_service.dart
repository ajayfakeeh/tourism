import 'package:location/data/models/trending_spot.dart';

class TrendingService {
  Future<List<TrendingSpot>> getTrendingSpots() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy JSON Data
    final List<Map<String, dynamic>> dummyData = [
      {
        'id': '1',
        'name': 'Skyline Secret Garden',
        'imageUrl':
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&auto=format&fit=crop',
        'location': 'Downtown Rooftop',
        'rating': '4.9',
        'tags': ['#DateNight', '#View', '#Cocktails'],
        'socialProof': 'Viral on TikTok 🎵',
        'category': 'Experience',
        'isVideo': true,
      },
      {
        'id': '2',
        'name': 'Neon Noodle Alley',
        'imageUrl':
            'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500&auto=format&fit=crop',
        'location': 'Chinatown',
        'rating': '4.7',
        'tags': ['#HiddenGem', '#Spicy', '#StreetFood'],
        'socialProof': 'Saved by 12.5k people 💾',
        'category': 'Food',
        'isVideo': false,
      },
      {
        'id': '3',
        'name': 'The Glasshouse Cafe',
        'imageUrl':
            'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=500&auto=format&fit=crop',
        'location': 'Botanical Gardens',
        'rating': '4.8',
        'tags': ['#Aesthetic', '#Brunch', '#Nature'],
        'socialProof': 'Trending on Insta 📸',
        'category': 'Food',
        'isVideo': false,
      },
      {
        'id': '4',
        'name': 'Retro Arcade Bar',
        'imageUrl':
            'https://images.unsplash.com/photo-1511882150382-421056c89033?w=500&auto=format&fit=crop',
        'location': 'West End',
        'rating': '4.6',
        'tags': ['#Retro', '#Gaming', '#Fun'],
        'socialProof': 'Crowd Favorite 🔥',
        'category': 'Experience',
        'isVideo': true,
      },
      {
        'id': '5',
        'name': 'Midnight Matcha Spot',
        'imageUrl':
            'https://images.unsplash.com/photo-1515281239448-201ea32d5252?w=500&auto=format&fit=crop',
        'location': 'Old Town',
        'rating': '5.0',
        'tags': ['#LateNight', '#Dessert'],
        'socialProof': 'New Opening ✨',
        'category': 'Food',
        'isVideo': false,
      },
    ];

    return dummyData.map((json) => TrendingSpot.fromJson(json)).toList();
  }
}
