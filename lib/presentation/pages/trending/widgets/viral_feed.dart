import 'package:flutter/material.dart';
import 'package:location/data/models/trending_spot.dart';
import 'package:location/presentation/pages/trending/widgets/viral_feed_item.dart';

class ViralFeed extends StatelessWidget {
  final List<TrendingSpot> spots;
  const ViralFeed({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: spots.length,
      itemBuilder: (context, index) {
        final spot = spots[index];
        return ViralFeedItem(spot: spot);
      },
    );
  }
}
