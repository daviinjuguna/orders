import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class WatchOrderUseCase extends NoParamsStreamUseCase<List<OrderEntity>> {
  WatchOrderUseCase(this._repo);

  @override
  Stream<Either<String, List<OrderEntity>>> call(NoParams params) {
    return _repo.watchOrders();
  }

  final ProductRepo _repo;
}
