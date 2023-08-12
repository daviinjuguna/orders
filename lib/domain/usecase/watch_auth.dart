import 'package:order_app/domain/domain.dart';

class WatchAuthUseCase {
  WatchAuthUseCase(this._repo);

  final AuthRepo _repo;

  Stream<UserEntity> call() => _repo.checkAuth();
}
