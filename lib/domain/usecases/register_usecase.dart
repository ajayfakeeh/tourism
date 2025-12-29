import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/domain/entities/user.dart';
import 'package:location/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(
    String name,
    String email,
    String password,
  ) async {
    return await repository.register(name, email, password);
  }
}
