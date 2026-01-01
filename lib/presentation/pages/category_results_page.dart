import 'package:flutter/material.dart';

class CategoryResultsPage extends StatelessWidget {
  final String categoryName;

  const CategoryResultsPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Mock Data based on category (Simple switch for now)
    final List<Map<String, dynamic>> results = _getMockResults(categoryName);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          'Best $categoryName',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(label: 'Open Now', isSelected: true),
                const SizedBox(width: 8),
                _FilterChip(label: 'Rating 4.0+'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Under 30 mins'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Budget Friendly'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = results[index];
                return _RestaurantCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockResults(String category) {
    if (category == 'Breakfast') {
      return [
        {
          'name': 'The Morning Toast',
          'rating': '4.8',
          'time': '12 mins',
          'image':
              'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=500&q=80',
          'tags': ['Pancakes', 'Coffee'],
        },
        {
          'name': 'South Idli House',
          'rating': '4.5',
          'time': '8 mins',
          'image':
              'https://images.unsplash.com/photo-1589301760576-41f4739112d8?w=500&q=80',
          'tags': ['Veg', 'South Indian'],
        },
      ];
    } else if (category == 'Lunch') {
      return [
        {
          'name': 'Spicy Biriyani Pot',
          'rating': '4.9',
          'time': '25 mins',
          'image':
              'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500&q=80',
          'tags': ['Biriyani', 'Halal'],
        },
        {
          'name': 'Green Leaf Buffet',
          'rating': '4.2',
          'time': '15 mins',
          'image':
              'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500&q=80',
          'tags': ['Veg', 'Buffet'],
        },
      ];
    }
    // Default for others
    return [
      {
        'name': '$category Spot #1',
        'rating': '4.5',
        'time': '10 mins',
        'image':
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80',
        'tags': ['Popular', 'Tasty'],
      },
      {
        'name': '$category Place #2',
        'rating': '4.3',
        'time': '22 mins',
        'image':
            'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=500&q=80',
        'tags': ['Cozy', 'Good Value'],
      },
    ];
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _RestaurantCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              item['item'] ?? item['image'], // Fallback
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['rating'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      item['time'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      (item['tags'] as List).join(' • '),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
