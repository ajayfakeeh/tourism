import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class EmergencyHeader extends StatelessWidget {
  const EmergencyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          'Emergency',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textColor,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
