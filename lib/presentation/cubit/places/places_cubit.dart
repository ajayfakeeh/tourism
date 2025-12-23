import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/domain/repositories/places_repository.dart';
import 'package:location/presentation/cubit/places/places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlacesRepository repository;

  PlacesCubit({required this.repository}) : super(PlacesInitial());

  Future<void> fetchPlaces(String type) async {
    emit(PlacesLoading());
    // Using default lat/lng for now, in real app get from LocationService
    final result = await repository.getPlaces(type, 11.258, 75.780);
    result.fold(
      (failure) => emit(PlacesError(failure.message)),
      (places) => emit(PlacesLoaded(places)),
    );
  }
}
