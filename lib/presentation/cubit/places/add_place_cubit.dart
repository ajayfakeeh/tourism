import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/domain/repositories/places_repository.dart';

abstract class AddPlaceState extends Equatable {
  const AddPlaceState();
  @override
  List<Object> get props => [];
}

class AddPlaceInitial extends AddPlaceState {}

class AddPlaceLoading extends AddPlaceState {}

class AddPlaceSuccess extends AddPlaceState {}

class AddPlaceError extends AddPlaceState {
  final String message;
  const AddPlaceError(this.message);
}

class AddPlaceCubit extends Cubit<AddPlaceState> {
  final PlacesRepository repository;

  AddPlaceCubit({required this.repository}) : super(AddPlaceInitial());

  Future<void> addNewPlace(Place place) async {
    emit(AddPlaceLoading());
    final result = await repository.addPlace(place);
    result.fold(
      (failure) => emit(AddPlaceError(failure.message)),
      (_) => emit(AddPlaceSuccess()),
    );
  }
}
