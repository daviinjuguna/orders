import 'package:bloc/bloc.dart';
import 'package:order_app/domain/domain.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._useCase) : super(CheckoutState.initial);

  final CheckoutUseCase _useCase;

  Future<void> checkout({
    required double amount,
    required List<ProductEntity> products,
  }) async {
    emit(CheckoutState.loading);
    final result = await _useCase.call(CheckoutParams(
      amount: amount,
      products: products,
    ));
    result.fold(
      (l) => emit(CheckoutState.failure),
      (r) => emit(CheckoutState.success),
    );
  }
}
