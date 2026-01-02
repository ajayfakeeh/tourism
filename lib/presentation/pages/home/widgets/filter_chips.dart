import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class FilterChips extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String selectedCategoryId;
  final Function(String) onCategorySelected;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category['id'] == selectedCategoryId;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(category['name']),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onCategorySelected(category['id']);
                }
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF1B2A32),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: isSelected
                    ? BorderSide.none
                    : const BorderSide(color: Colors.black12),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
