import 'package:location/core/network/dio_client.dart';
import 'package:location/data/models/user_model.dart';
import 'package:location/core/error/failures.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String phone, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login(String phone, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock Response
    final response = {
      "status": true,
      "user": {
        "id": 1,
        "name": "Ajay",
        "phone": phone.isEmpty ? "9876543210" : phone,
      },
      "token": "dummy_token_123",
    };

    // In a real scenario, use dio:
    // final response = await dioClient.dio.post(ApiEndpoints.login, data: {'phone': phone, 'password': password});

    if (response['status'] == true) {
      return UserModel.fromJson(response['user'] as Map<String, dynamic>);
    } else {
      throw const ServerFailure('Login failed');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock Response
    final response = {
      "status": true,
      "user": {"id": 2, "name": name, "email": email},
      "token": "dummy_token_456",
    };

    if (response['status'] == true) {
      return UserModel.fromJson(response['user'] as Map<String, dynamic>);
    } else {
      throw const ServerFailure('Registration failed');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulated Text response or just void
    return;
  }
}
