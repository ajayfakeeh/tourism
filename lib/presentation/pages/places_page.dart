import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/places/places_cubit.dart';
import 'package:location/presentation/cubit/places/places_state.dart';

class PlacesPage extends StatelessWidget {
  final String type;

  const PlacesPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${type.toUpperCase()} Places')),
      body: BlocProvider(
        create: (context) => getIt<PlacesCubit>()..fetchPlaces(type),
        child: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlacesLoaded) {
              if (state.places.isEmpty) {
                return const Center(child: Text("No places found"));
              }
              return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) {
                  final place = state.places[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        place.type == 'hotel'
                            ? Icons.hotel
                            : place.type == 'tourist'
                            ? Icons.landscape
                            : place.type == 'parking'
                            ? Icons.local_parking
                            : Icons.restaurant,
                      ),
                      title: Text(place.name),
                      subtitle: Text(
                        '${place.distance} km away\n${place.description ?? ""}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            } else if (state is PlacesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
