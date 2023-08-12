import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class LogoutUseCase extends NoParamsUseCase<Unit> {
  LogoutUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(NoParams params) => _repo.logout();
  final AuthRepo _repo;
}
