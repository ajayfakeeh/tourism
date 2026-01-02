import 'package:flutter/material.dart';

class ForecastSection extends StatelessWidget {
  final List<Map<String, dynamic>> forecast;
  final bool isLoading;
  final VoidCallback onLoadMore;

  const ForecastSection({
    super.key,
    required this.forecast,
    required this.isLoading,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    // If we have data or are loading, show the section
    if (forecast.isEmpty && !isLoading) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            '7-Day Forecast',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160, // Height for the cards
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == forecast.length) {
                return Center(
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextButton(
                          onPressed: onLoadMore,
                          child: const Text('Load More'),
                        ),
                );
              }
              final day = forecast[index];
              return _WeatherDayCard(day: day);
            },
          ),
        ),
      ],
    );
  }
}

class _WeatherDayCard extends StatelessWidget {
  final Map<String, dynamic> day;

  const _WeatherDayCard({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day['dayName'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day['date'],
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const SizedBox(height: 8),
          Icon(
            day['icon'] == 'sunny' ? Icons.wb_sunny : Icons.cloud,
            color: Colors.orange,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            day['temperature'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day['condition'],
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
