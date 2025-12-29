import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/domain/usecases/login_usecase.dart';
import 'package:location/domain/usecases/register_usecase.dart';
import 'package:location/domain/usecases/forgot_password_usecase.dart';
import 'package:location/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordUseCase,
  }) : super(AuthInitial());

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(phone, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    final result = await registerUseCase(name, email, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(PasswordResetSent()), // Or a specific success state if needed
    );
  }
}
