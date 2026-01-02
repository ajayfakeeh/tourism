import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/pages/reviews/widgets/review_item.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for Reviews
    final reviews = [
      {
        'user': 'Alice M.',
        'image': 'https://i.pravatar.cc/150?img=1',
        'place': 'Ramen Nagi',
        'rating': 5,
        'date': '2 days ago',
        'text':
            'Absolutely improved my mood! The spicy miso ramen is a must-try. The staff was super friendly too.',
      },
      {
        'user': 'John D.',
        'image': 'https://i.pravatar.cc/150?img=11',
        'place': 'Tea Valley',
        'rating': 4,
        'date': '1 week ago',
        'text': 'Great view and cozy atmosphere. Perfect for a rainy day.',
      },
      {
        'user': 'Sarah W.',
        'image': 'https://i.pravatar.cc/150?img=5',
        'place': 'Spicy Treats',
        'rating': 5,
        'date': '3 weeks ago',
        'text': 'Best Indian food in town. The butter chicken was divine!',
      },
      {
        'user': 'Mike T.',
        'image': 'https://i.pravatar.cc/150?img=3',
        'place': 'Cool Scoops',
        'rating': 4,
        'date': '1 month ago',
        'text': 'Ice cream was good, but it was a bit crowded.',
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Your Reviews'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return ReviewItem(
            user: review['user'] as String,
            image: review['image'] as String,
            place: review['place'] as String,
            rating: review['rating'] as int,
            date: review['date'] as String,
            text: review['text'] as String,
          );
        },
      ),
    );
  }
}
