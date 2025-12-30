import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/di/injector.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/cubit/places/add_place_cubit.dart';
import 'package:location/presentation/pages/map_page.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _contactController = TextEditingController();
  String _selectedType = 'Tourist Attraction';
  LatLng? _selectedLocation; // Mocking selection for now

  // Constants from mockup
  final Color _primaryColor = AppTheme.primaryColor; // 0xFF00695C
  final Color _lightGreen = const Color(
    0xFFE8F5E9,
  ); // Light background for badge

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'NEW CONTRIBUTION',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<AddPlaceCubit>(),
        child: BlocConsumer<AddPlaceCubit, AddPlaceState>(
          listener: (context, state) {
            if (state is AddPlaceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Place Added Successfully')),
              );
              // Clear form
              _nameController.clear();
              _descController.clear();
              _contactController.clear();
              setState(() {
                _selectedLocation = null;
              });
            } else if (state is AddPlaceError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Place',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Help others discover great spots on their journey.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Category
                    _buildLabel('Category'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedType,
                          isExpanded: true,
                          icon: const Icon(Icons.expand_more),
                          items:
                              [
                                'Tourist Attraction',
                                'Hotel',
                                'Restaurant',
                                'Parking',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Icon(
                                        _getIconForType(value),
                                        color: _primaryColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val != null)
                              setState(() => _selectedType = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Place Name
                    _buildLabel('Place Name'),
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration(
                        hint: 'Enter place name',
                        icon: Icons.storefront,
                      ),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),

                    // Location Selector
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MapPage(isSelecting: true),
                          ),
                        );

                        if (result != null && result is Map) {
                          setState(() {
                            _selectedLocation = result['location'] as LatLng;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected: ${result['name']}'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2F1), // Light Teal
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00695C),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.map,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedLocation == null
                                        ? 'Select Location on Map'
                                        : 'Location Selected',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _selectedLocation == null
                                        ? 'Tap to pin the exact spot'
                                        : '${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}',
                                    style: const TextStyle(
                                      color: Color(0xFF00695C),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    _buildLabel('Description'),
                    TextFormField(
                      controller: _descController,
                      maxLines: 4,
                      decoration: _buildInputDecoration(
                        hint:
                            'Describe this place briefly. What makes it special?',
                      ).copyWith(contentPadding: const EdgeInsets.all(16)),
                    ),
                    const SizedBox(height: 24),

                    // Contact
                    _buildLabel('Contact Number (Optional)'),
                    TextFormField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: _buildInputDecoration(
                        hint: '+1 (555) 000-0000',
                        icon: Icons.phone,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Photos (Mock UI)
                    _buildLabel('Photos'),
                    Row(
                      children: [
                        // Add Button
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Mock Image 1
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Submit Button
                    if (state is AddPlaceLoading)
                      Center(
                        child: CircularProgressIndicator(color: _primaryColor),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedLocation != null) {
                              final place = Place(
                                id: 0,
                                name: _nameController.text,
                                type: _selectedType.toLowerCase(),
                                latitude: _selectedLocation!.latitude,
                                longitude: _selectedLocation!.longitude,
                                distance: 0,
                                description: _descController.text,
                                contact: _contactController.text,
                              );
                              context.read<AddPlaceCubit>().addNewPlace(place);
                            } else if (_selectedLocation == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a location'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF66BB6A,
                            ), // Light Green
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Submit Place',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
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
