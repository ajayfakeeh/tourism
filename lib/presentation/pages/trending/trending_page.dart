import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/trending/trending_cubit.dart';
import 'package:location/presentation/cubit/trending/trending_state.dart';
import 'package:location/presentation/pages/trending/widgets/trending_stories.dart';
import 'package:location/presentation/pages/trending/widgets/viral_feed.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingCubit()..loadTrendingSpots(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA), // Light Theme
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Trending Nearby 🔥',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<TrendingCubit, TrendingState>(
          builder: (context, state) {
            if (state is TrendingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrendingLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TrendingStories(spots: state.spots),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Viral On TikTok & Insta 📸',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, // Dark Text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ViralFeed(spots: state.spots),
                  ],
                ),
              );
            } else if (state is TrendingError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
