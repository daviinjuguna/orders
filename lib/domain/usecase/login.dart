import 'package:dartz/dartz.dart';

import 'package:order_app/domain/domain.dart';

class LoginUseCase extends UnitUseCase<AuthParams> {
  LoginUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(AuthParams params) =>
      _repo.login(params.email, params.password);

  final AuthRepo _repo;
}

class AuthParams {
  final String email;
  final String password;

  AuthParams(
    this.email,
    this.password,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthParams &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
