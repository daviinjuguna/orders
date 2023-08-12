import 'package:dartz/dartz.dart';
import 'package:order_app/domain/domain.dart';

class HomeDisplayUseCase extends NoParamsStreamUseCase<HomeDisplay> {
  HomeDisplayUseCase(this._repo);

  @override
  Stream<Either<String, HomeDisplay>> call(NoParams params) {
    return _repo.watchHomeDisplay();
  }

  final ProductRepo _repo;
}
