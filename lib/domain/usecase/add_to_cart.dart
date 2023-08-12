import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class AddToCartUseCase extends UseCase<Unit, ProductEntity> {
  AddToCartUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(ProductEntity params) {
    return _repo.addToCart(params);
  }

  final ProductRepo _repo;
}
