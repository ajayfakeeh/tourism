import 'package:flutter/material.dart';
import 'package:location/data/models/trending_spot.dart';

class TrendingStories extends StatelessWidget {
  final List<TrendingSpot> spots;
  const TrendingStories({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: spots.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final spot = spots[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(spot.imageUrl),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                spot.name.split(' ').first,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
