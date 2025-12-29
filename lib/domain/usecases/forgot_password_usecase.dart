import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return await repository.forgotPassword(email);
  }
}
