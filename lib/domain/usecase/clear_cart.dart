import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class ClearCartUseCase extends UseCase<Unit, ProductEntity?> {
  ClearCartUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(ProductEntity? params) {
    return _repo.clearCart(params);
  }

  final ProductRepo _repo;
}
