import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    // Mock implementation
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      if (email == 'test@test.com' && password == 'password') {
        return Right(
          const User(
            id: '1',
            email: 'test@test.com',
            name: 'Test User',
          ),
        );
      }
      return const Left(AuthFailure('Invalid credentials'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup(
      String email, String password, String name) async {
    // Mock implementation
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      return Right(
        User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email,
          name: name,
        ),
      );
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    // Mock implementation
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    // Mock implementation
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      if (email.isNotEmpty) {
        return const Right(null);
      }
      return const Left(AuthFailure('Please enter a valid email'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
