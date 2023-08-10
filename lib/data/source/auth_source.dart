import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app/data/data.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
  Stream<UserModel?> checkAuth();
}

class AuthSourceImpl implements AuthSource {
  final FirebaseAuth _auth;

  AuthSourceImpl(this._auth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User is null");
      }
      return UserModel(
        uid: user.uid,
        email: user.email!,
      );
    } catch (e, s) {
      log("login", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User is null");
      }
      return UserModel(
        uid: user.uid,
        email: user.email!,
      );
    } catch (e, s) {
      log("register", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e, s) {
      log("logout", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Stream<UserModel?> checkAuth() async* {
    yield* _auth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      }
      return UserModel(
        uid: user.uid,
        email: user.email!,
      );
    }).onErrorReturnWith((e, s) {
      log("checkAuth", error: e, stackTrace: s);
      return null;
    });
  }
}
