import 'package:flutter/material.dart';
import 'package:location/presentation/pages/category_results/widgets/filter_chips_list.dart';
import 'package:location/presentation/pages/category_results/widgets/result_item_card.dart';

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
          const FilterChipsList(),
          const SizedBox(height: 16),
          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = results[index];
                return ResultItemCard(item: item);
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
