import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String phone, String password);
}
