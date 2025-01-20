import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
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
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String email,
      String password,
      String name,) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Right(
        User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email,
          name: name,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
