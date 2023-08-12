import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:order_app/domain/domain.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(const AuthState());
  final AuthRepo _repo;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password, state.confirmPassword]),
      loginValid: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password, state.confirmPassword]),
      loginValid: Formz.validate([state.email, password]),
    ));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate([state.email, state.password, confirmPassword]),
      loginValid: Formz.validate([state.email, state.password]),
    ));
  }

  void register() async {
    if (!state.isValid) return;
    await _action(_repo.register(
      state.email.value,
      state.password.value,
    ));
  }

  void login() async {
    if (!state.loginValid) return;
    await _action(_repo.login(
      state.email.value,
      state.password.value,
    ));
  }

  Future<void> _action(Future<Either<String, Unit>> call) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await call;
    emit(result.fold(
      (l) => state.copyWith(
        status: FormzSubmissionStatus.failure,
        error: l,
      ),
      (r) => state.copyWith(
        status: FormzSubmissionStatus.success,
        error: '',
      ),
    ));
  }
}
