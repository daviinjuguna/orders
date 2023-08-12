import 'package:dartz/dartz.dart';

export 'add_to_cart.dart';
export 'checkout.dart';
export 'clear_cart.dart';
export 'home_display.dart';
export 'login.dart';
export 'logout.dart';
export 'order.dart';
export 'register.dart';
export 'remove_from_cart.dart';
export 'watch_auth.dart';
export 'products.dart';

abstract class UseCase<T, P> {
  Future<Either<String, T>> call(P params);
}

abstract class StreamUseCase<T, P> {
  Stream<Either<String, T>> call(P params);
}

abstract class UnitUseCase<P> extends UseCase<Unit, P> {}

abstract class NoParamsUseCase<T> extends UseCase<T, NoParams> {}

abstract class NoParamsStreamUseCase<T> extends StreamUseCase<T, NoParams> {}

// abstract class StreamUseCase<P> extends _StreamUseCase<Unit, P> {}

class NoParams {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoParams;
  }

  @override
  int get hashCode => 0;
}
