import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/domain/entities/user.dart';
import 'package:location/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String phone, String password) async {
    return await repository.login(phone, password);
  }
}
