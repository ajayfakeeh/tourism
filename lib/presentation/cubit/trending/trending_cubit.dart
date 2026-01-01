import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/data/datasources/trending_service.dart';
import 'package:location/presentation/cubit/trending/trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final TrendingService _service;

  TrendingCubit() : _service = TrendingService(), super(TrendingInitial());

  Future<void> loadTrendingSpots() async {
    try {
      emit(TrendingLoading());
      final spots = await _service.getTrendingSpots();
      emit(TrendingLoaded(spots));
    } catch (e) {
      emit(TrendingError('Failed to load trending spots'));
    }
  }
}
