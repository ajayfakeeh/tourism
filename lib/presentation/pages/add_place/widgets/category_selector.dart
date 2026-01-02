import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/pages/add_place/widgets/form_label.dart';

class CategorySelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String?> onChanged;

  const CategorySelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: 'Category'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              isExpanded: true,
              icon: const Icon(Icons.expand_more),
              items: ['Tourist Attraction', 'Hotel', 'Restaurant', 'Parking']
                  .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            _getIconForType(value),
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            value,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  })
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Tourist Attraction':
        return Icons.filter_hdr;
      case 'Hotel':
        return Icons.hotel;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Parking':
        return Icons.local_parking;
      default:
        return Icons.place;
    }
  }
}
