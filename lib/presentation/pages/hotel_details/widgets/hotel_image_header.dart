import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';

class HotelImageHeader extends StatelessWidget {
  final Place place;

  const HotelImageHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      iconTheme: const IconThemeData(color: Colors.white), // Contrast for image
      flexibleSpace: FlexibleSpaceBar(
        background: place.imageUrl != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    place.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(color: Colors.grey),
      ),
    );
  }
}
