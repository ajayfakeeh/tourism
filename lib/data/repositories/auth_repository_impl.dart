import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/data/datasources/remote/auth_remote_datasource.dart';
import 'package:location/domain/entities/user.dart';
import 'package:location/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String phone, String password) async {
    try {
      final userModel = await remoteDataSource.login(phone, password);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
