import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app/data/data.dart';
import 'package:order_app/domain/domain.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthSource _source;

  AuthRepoImpl(this._source);

  @override
  Future<Either<String, Unit>> login(String email, String password) async {
    try {
      await _source.login(email, password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left('Invalid email or password');
      }
      if (e.code == 'invalid-email') {
        return left('Invalid email');
      }
      return left('Something went wrong');
    } catch (_) {
      return left('Something went wrong');
    }
  }

  @override
  Future<Either<String, Unit>> register(String email, String password) async {
    try {
      await _source.register(email, password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('Password is too weak');
      }
      if (e.code == 'invalid-email') {
        return left('Invalid email');
      }
      return left('Something went wrong');
    } catch (_) {
      return left('Something went wrong');
    }
  }

  @override
  Future<Either<String, Unit>> logout() async {
    try {
      _source.logout();
      return right(unit);
    } catch (_) {
      return left('Something went wrong');
    }
  }

  @override
  Stream<UserEntity> checkAuth() => _source.checkAuth().map((user) {
        if (user == null) {
          return UserEntity.unauthenticated();
        }
        return UserEntity.authenticated(uid: user.uid, email: user.email!);
      });
}
