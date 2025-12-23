import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/domain/usecases/login_usecase.dart';
import 'package:location/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(AuthInitial());

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(phone, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
