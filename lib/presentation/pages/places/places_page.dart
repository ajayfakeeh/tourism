import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/places/places_cubit.dart';
import 'package:location/presentation/cubit/places/places_state.dart';
import 'package:location/presentation/pages/places/widgets/places_list_item.dart';

class PlacesPage extends StatelessWidget {
  final String type;

  const PlacesPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          '${type.toUpperCase()} Places',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppTheme.textColor),
      ),
      body: BlocProvider(
        create: (context) => getIt<PlacesCubit>()..fetchPlaces(type),
        child: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryColor),
              );
            } else if (state is PlacesLoaded) {
              if (state.places.isEmpty) {
                return Center(
                  child: Text(
                    "No places found",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.places.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return PlacesListItem(place: state.places[index]);
                },
              );
            } else if (state is PlacesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
