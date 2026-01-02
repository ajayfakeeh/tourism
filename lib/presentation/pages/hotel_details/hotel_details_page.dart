import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/pages/hotel_details/widgets/hotel_bottom_actions.dart';
import 'package:location/presentation/pages/hotel_details/widgets/hotel_description.dart';
import 'package:location/presentation/pages/hotel_details/widgets/hotel_image_header.dart';
import 'package:location/presentation/pages/hotel_details/widgets/hotel_reviews_list.dart';
import 'package:location/presentation/pages/hotel_details/widgets/hotel_title_section.dart';

class HotelDetailsPage extends StatelessWidget {
  final Place place;

  const HotelDetailsPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              HotelImageHeader(place: place),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HotelTitleSection(place: place),
                      const SizedBox(height: 24),
                      HotelDescription(place: place),
                      const SizedBox(height: 24),
                      HotelReviewsList(place: place),
                      const SizedBox(height: 100), // Space for bottom buttons
                    ],
                  ),
                ),
              ),
            ],
          ),
          HotelBottomActions(place: place),
        ],
      ),
    );
  }
}
