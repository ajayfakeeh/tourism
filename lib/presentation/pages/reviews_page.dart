import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

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
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        review['user'] as String? ?? '',
                      ),
                      // Fallback if image fails (though NetworkImage doesn't handle error easily in bare widget,
                      // keeping simplified for mock)
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['place'] as String,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            review['user'] as String,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              Icons.star,
                              size: 14,
                              color: starIndex < (review['rating'] as int)
                                  ? AppTheme.accentColor
                                  : Colors.grey[300],
                            );
                          }),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          review['date'] as String,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review['text'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
