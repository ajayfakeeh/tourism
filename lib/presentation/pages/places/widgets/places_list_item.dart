import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/pages/hotel_details/hotel_details_page.dart';

class PlacesListItem extends StatelessWidget {
  final Place place;

  const PlacesListItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (place.type == 'hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HotelDetailsPage(place: place),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    place.type == 'hotel'
                        ? Icons.hotel
                        : place.type == 'tourist'
                        ? Icons.landscape
                        : place.type == 'parking'
                        ? Icons.local_parking
                        : Icons.restaurant,
                    color: AppTheme.primaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppTheme.subtitleColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${place.distance} km away',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      if (place.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          place.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.subtitleColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
