import 'package:get_it/get_it.dart';
import 'package:location/core/location/location_service.dart';
import 'package:location/core/network/dio_client.dart';
import 'package:location/data/datasources/remote/auth_remote_datasource.dart';
import 'package:location/data/repositories/auth_repository_impl.dart';
import 'package:location/data/repositories/map_repository_impl.dart';
import 'package:location/data/repositories/places_repository_impl.dart';
import 'package:location/domain/repositories/auth_repository.dart';
import 'package:location/domain/repositories/map_repository.dart';
import 'package:location/domain/repositories/places_repository.dart';
import 'package:location/domain/usecases/login_usecase.dart';
import 'package:location/domain/usecases/register_usecase.dart';
import 'package:location/domain/usecases/forgot_password_usecase.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';
import 'package:location/presentation/cubit/places/add_place_cubit.dart';
import 'package:location/presentation/cubit/places/places_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerLazySingleton(() => LocationService());

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<MapRepository>(
    () => MapRepositoryImpl(locationService: getIt()),
  );
  getIt.registerLazySingleton<PlacesRepository>(() => PlacesRepositoryImpl());

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));

  // Cubits
  getIt.registerFactory(
    () => AuthCubit(
      loginUseCase: getIt(),
      registerUseCase: getIt(),
      forgotPasswordUseCase: getIt(),
    ),
  );
  getIt.registerFactory(() => MapCubit(mapRepository: getIt()));
  getIt.registerFactory(() => PlacesCubit(repository: getIt()));
  getIt.registerFactory(() => AddPlaceCubit(repository: getIt()));
}
