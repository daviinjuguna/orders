import 'package:bloc/bloc.dart';
import 'package:order_app/domain/domain.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._repo) : super(LogoutState.initial);

  final AuthRepo _repo;

  Future<void> logout() async {
    emit(LogoutState.loading);
    final res = await _repo.logout();
    res.fold(
      (l) => emit(LogoutState.error),
      (r) => emit(LogoutState.success),
    );
  }
}
