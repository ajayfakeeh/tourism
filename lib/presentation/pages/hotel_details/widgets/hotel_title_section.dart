import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/pages/hotel_details/widgets/rating_bar.dart';

class HotelTitleSection extends StatelessWidget {
  final Place place;

  const HotelTitleSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            place.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: RatingBar(rating: place.rating ?? 0),
        ),
      ],
    );
  }
}
