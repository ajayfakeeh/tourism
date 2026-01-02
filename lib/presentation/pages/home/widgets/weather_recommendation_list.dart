import 'package:flutter/material.dart';

class WeatherRecommendationList extends StatelessWidget {
  final List<Map<String, dynamic>> spots;
  const WeatherRecommendationList({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Matching the height of ForgotToSaveList
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: spots.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final spot = spots[index];
          return _WeatherPlaceCard(spot: spot);
        },
      ),
    );
  }
}

class _WeatherPlaceCard extends StatelessWidget {
  final Map<String, dynamic> spot;

  const _WeatherPlaceCard({required this.spot});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(spot['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  spot['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(
                      '${spot['rating']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '• ${spot['distance']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Perfect Match',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
