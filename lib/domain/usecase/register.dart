import 'package:dartz/dartz.dart';

import 'package:order_app/domain/domain.dart';

class RegisterUseCase extends UnitUseCase<AuthParams> {
  RegisterUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(AuthParams params) =>
      _repo.register(params.email, params.password);

  final AuthRepo _repo;
}
