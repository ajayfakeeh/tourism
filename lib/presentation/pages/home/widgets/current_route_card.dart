import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/cubit/home/home_cubit.dart';

class CurrentRouteCard extends StatelessWidget {
  final Map<String, dynamic>? weather;
  final bool isForecastVisible;

  const CurrentRouteCard({
    super.key,
    this.weather,
    this.isForecastVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1), // Light Teal/Green
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.green, // Brighter green for icon bg
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.swap_calls, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Route',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.subtitleColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: const [
                      TextSpan(text: 'Kyoto '),
                      WidgetSpan(child: Icon(Icons.arrow_forward, size: 14)),
                      TextSpan(text: ' Osaka'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (weather != null) ...[
                InkWell(
                  onTap: () {
                    final cubit = context.read<HomeCubit>();
                    cubit.toggleForecastVisibility();
                  },
                  child: Row(
                    children: [
                      Icon(
                        weather!['icon'] == 'sunny'
                            ? Icons.wb_sunny
                            : Icons.cloud,
                        color: Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        weather!['temperature'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isForecastVisible
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                Text(
                  weather!['condition'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.subtitleColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
