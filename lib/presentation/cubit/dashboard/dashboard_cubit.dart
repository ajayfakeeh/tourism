import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/dashboard/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void loadDashboard() {
    // Add any dashboard loading logic here
    emit(DashboardLoaded());
  }
}
