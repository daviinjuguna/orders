part of 'auth_cubit.dart';

@immutable
class AuthState {
  final EmailInput email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final FormzSubmissionStatus status;
  final String error;
  final bool isValid;
  final bool loginValid;

  const AuthState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.error = '',
    this.isValid = false,
    this.loginValid = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.status == status &&
        other.error == error &&
        other.isValid == isValid &&
        other.loginValid == loginValid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        status.hashCode ^
        error.hashCode ^
        isValid.hashCode ^
        loginValid.hashCode;
  }

  AuthState copyWith({
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    FormzSubmissionStatus? status,
    String? error,
    bool? isValid,
    bool? loginValid,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
      loginValid: loginValid ?? this.loginValid,
    );
  }
}
