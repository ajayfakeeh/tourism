import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/di/injector.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/cubit/places/add_place_cubit.dart';

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
  String _selectedType = 'hotel';
  LatLng?
  _selectedLocation; // Mocking selection for now, or use a simple picker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Place')),
      body: BlocProvider(
        create: (context) => getIt<AddPlaceCubit>(),
        child: BlocConsumer<AddPlaceCubit, AddPlaceState>(
          listener: (context, state) {
            if (state is AddPlaceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Place Added Successfully')),
              );
              Navigator.pop(context);
            } else if (state is AddPlaceError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      items: const [
                        DropdownMenuItem(value: 'hotel', child: Text('Hotel')),
                        DropdownMenuItem(
                          value: 'tourist',
                          child: Text('Tourist Place'),
                        ),
                        DropdownMenuItem(
                          value: 'parking',
                          child: Text('Parking'),
                        ),
                        DropdownMenuItem(value: 'food', child: Text('Food')),
                      ],
                      onChanged: (val) => setState(() => _selectedType = val!),
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    TextFormField(
                      controller: _contactController,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Mock picking location
                        setState(() {
                          _selectedLocation = const LatLng(11.258, 75.780);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Location Selected (Mock)'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map),
                      label: Text(
                        _selectedLocation == null
                            ? 'Select Location on Map'
                            : 'Location Selected',
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (state is AddPlaceLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedLocation != null) {
                            final place = Place(
                              id: 0, // Auto-generated in backend
                              name: _nameController.text,
                              type: _selectedType,
                              latitude: _selectedLocation!.latitude,
                              longitude: _selectedLocation!.longitude,
                              distance: 0, // Calculated by backend
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
                        child: const Text('Submit'),
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
}
