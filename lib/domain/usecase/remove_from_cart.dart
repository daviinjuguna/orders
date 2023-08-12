import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class RemoveFromCartUseCase extends UseCase<Unit, String> {
  RemoveFromCartUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(String params) {
    return _repo.removeFromCart(params);
  }

  final ProductRepo _repo;
}
