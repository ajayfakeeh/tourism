import 'package:flutter/material.dart';
import 'package:location/presentation/pages/category_results/category_results_page.dart';

class ScatteredCategoryGrid extends StatelessWidget {
  const ScatteredCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'What\'s on your mind?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: Row(
            children: [
              // Column 1: Breakfast (Tall)
              Expanded(
                flex: 4,
                child: _CategoryTile(
                  title: 'Breakfast',
                  image:
                      'https://images.unsplash.com/photo-1533089862017-ec935e4073cd?w=500&q=80',
                  color: Colors.orange.shade100,
                  height: double.infinity,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CategoryResultsPage(categoryName: 'Breakfast'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Column 2: Stacked items
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // Row 1: Lunch & Beverages
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: _CategoryTile(
                              title: 'Lunch',
                              image:
                                  'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?w=500&q=80', // Biriyani/Rice
                              color: Colors.amber.shade100,
                              height: double.infinity,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CategoryResultsPage(
                                    categoryName: 'Lunch',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _CategoryTile(
                              title: 'Beverages',
                              image:
                                  'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500&q=80', // Soda/Juice
                              color: Colors.blue.shade100,
                              height: double.infinity,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CategoryResultsPage(
                                    categoryName: 'Beverages',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row 2: Tea/Snacks & Dinner
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: _CategoryTile(
                              title: 'Tea & Snacks',
                              image:
                                  'https://images.unsplash.com/photo-1621845173322-a987d6537706?w=500&q=80', // Tea/Coffee
                              color: Colors.brown.shade100,
                              height: double.infinity,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CategoryResultsPage(
                                    categoryName: 'Tea & Snacks',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _CategoryTile(
                              title: 'Dinner',
                              image:
                                  'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500&q=80', // Dinner/Grill
                              color: Colors.indigo.shade100,
                              height: double.infinity,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CategoryResultsPage(
                                    categoryName: 'Dinner',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final double height;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.title,
    required this.image,
    required this.color,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
