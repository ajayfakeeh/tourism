import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class ReviewItem extends StatelessWidget {
  final String user;
  final String image;
  final String place;
  final int rating;
  final String date;
  final String text;

  const ReviewItem({
    super.key,
    required this.user,
    required this.image,
    required this.place,
    required this.rating,
    required this.date,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                backgroundImage: NetworkImage(image),
                // Fallback can be handled by NetworkImage errorBuilder if needed, but keeping simple as per original
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(user, style: Theme.of(context).textTheme.bodySmall),
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
                        color: starIndex < rating
                            ? AppTheme.accentColor
                            : Colors.grey[300],
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
