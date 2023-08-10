import 'package:dartz/dartz.dart';
import 'package:order_app/data/data.dart';

abstract class AuthRepo {
  //user either
  Future<Either<String, Unit>> login(String email, String password);
  Future<Either<String, Unit>> register(String email, String password);
  Future<Either<String, Unit>> logout();
  Stream<UserModel> checkAuth();
}

class AuthRepoImpl implements AuthRepo {}
