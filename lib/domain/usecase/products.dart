import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class WatchProductsUseCase extends NoParamsStreamUseCase<List<ProductEntity>> {
  final ProductRepo _repo;

  WatchProductsUseCase(this._repo);

  @override
  Stream<Either<String, List<ProductEntity>>> call(NoParams params) {
    return _repo.getProducts();
  }
}
