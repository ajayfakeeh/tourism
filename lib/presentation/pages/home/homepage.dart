import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/cubit/home/home_cubit.dart';
import 'package:location/presentation/cubit/home/home_state.dart';
import 'package:location/presentation/pages/map/map_page.dart';
import 'package:location/presentation/pages/home/widgets/home_header.dart';
import 'package:location/presentation/pages/home/widgets/hero_section.dart';
import 'package:location/presentation/pages/home/widgets/current_route_card.dart';
import 'package:location/presentation/pages/home/widgets/forecast_section.dart';
import 'package:location/presentation/pages/home/widgets/scattered_category_grid.dart';
import 'package:location/presentation/pages/home/widgets/trending_strip.dart';
import 'package:location/presentation/pages/home/widgets/section_header.dart';
import 'package:location/presentation/pages/home/widgets/weather_recommendation_list.dart';
import 'package:location/presentation/pages/home/widgets/food_spots_list.dart';
import 'package:location/presentation/pages/home/widgets/emergency_strip.dart';
import 'package:location/presentation/pages/home/widgets/forgot_to_save_list.dart';
import 'package:location/presentation/pages/home/widgets/just_before_arrive_section.dart';
import 'package:location/presentation/pages/home/widgets/filter_chips.dart';
import 'package:location/presentation/pages/home/widgets/near_destination_list.dart';
import 'package:location/presentation/pages/home/widgets/create_plan_strip.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadHomeData(),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              } else if (state is HomeLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(
                        currentLocation: state.currentLocation,
                        onTapLocation: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MapPage(isSelecting: true),
                            ),
                          );
                          if (result != null &&
                              result is String &&
                              context.mounted) {
                            context.read<HomeCubit>().updateLocation(result);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      const HeroSection(),
                      const SizedBox(height: 24),
                      const CreatePlanStrip(),
                      const SizedBox(height: 24),
                      CurrentRouteCard(
                        weather: state.weather,
                        isForecastVisible: state.isForecastVisible,
                      ),
                      const SizedBox(height: 16),
                      // Embedded Forecast Section
                      if (state.isForecastVisible &&
                          (state.forecast.isNotEmpty ||
                              state.isForecastLoading))
                        ForecastSection(
                          forecast: state.forecast,
                          isLoading: state.isForecastLoading,
                          onLoadMore: () {
                            context.read<HomeCubit>().loadForecast();
                          },
                        ),
                      const SizedBox(height: 24),
                      const ScatteredCategoryGrid(),
                      const SizedBox(height: 24),
                      const TrendingStrip(),
                      const SizedBox(height: 24),
                      if (state.weatherRecommendations.isNotEmpty) ...[
                        const SectionHeader(
                          title: 'Perfect for this Weather',
                          actionText: 'See All',
                        ),
                        const SizedBox(height: 16),
                        WeatherRecommendationList(
                          spots: state.weatherRecommendations,
                        ),
                        const SizedBox(height: 24),
                      ],
                      const SectionHeader(
                        title: 'Food Spots On Your Way',
                        actionText: 'See Route',
                      ),
                      const SizedBox(height: 16),
                      FoodSpotsList(spots: state.foodSpotsOnWay),
                      const SizedBox(height: 24),
                      const EmergencyStrip(),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Food Spots You Forgot to Save',
                      ),
                      const SizedBox(height: 16),
                      ForgotToSaveList(items: state.forgotToSave),
                      const SizedBox(height: 24),
                      JustBeforeArriveSection(spots: state.justBeforeArrive),
                      const SizedBox(height: 24),
                      const SectionHeader(title: 'Near Your Destination'),
                      const SizedBox(height: 16),
                      FilterChips(
                        categories: state.categories,
                        selectedCategoryId: state.selectedCategoryId,
                        onCategorySelected: (id) {
                          context.read<HomeCubit>().selectCategory(id);
                        },
                      ),
                      const SizedBox(height: 16),
                      NearDestinationList(items: state.nearDestination),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
