import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/di/injector.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/presentation/cubit/places/add_place_cubit.dart';
import 'package:location/presentation/pages/add_place/widgets/add_place_header.dart';
import 'package:location/presentation/pages/add_place/widgets/category_selector.dart';
import 'package:location/presentation/pages/add_place/widgets/contact_input.dart';
import 'package:location/presentation/pages/add_place/widgets/contribution_badge.dart';
import 'package:location/presentation/pages/add_place/widgets/description_input.dart';
import 'package:location/presentation/pages/add_place/widgets/image_picker_section.dart';
import 'package:location/presentation/pages/add_place/widgets/location_selector.dart';
import 'package:location/presentation/pages/add_place/widgets/place_name_input.dart';
import 'package:location/presentation/pages/add_place/widgets/submit_button.dart';

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
  LatLng? _selectedLocation;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _selectedLocation != null) {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a location')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [ContributionBadge()],
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
                _selectedType = 'Tourist Attraction';
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
                    const AddPlaceHeader(),
                    const SizedBox(height: 32),
                    CategorySelector(
                      selectedType: _selectedType,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedType = val);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    PlaceNameInput(controller: _nameController),
                    const SizedBox(height: 24),
                    LocationSelector(
                      selectedLocation: _selectedLocation,
                      onLocationSelected: (location) {
                        setState(() {
                          _selectedLocation = location;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Location Selected')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    DescriptionInput(controller: _descController),
                    const SizedBox(height: 24),
                    ContactInput(controller: _contactController),
                    const SizedBox(height: 24),
                    const ImagePickerSection(),
                    const SizedBox(height: 40),
                    SubmitButton(
                      onPressed: _onSubmit,
                      isLoading: state is AddPlaceLoading,
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
