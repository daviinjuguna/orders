import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  /// ConfirmPassword is weak (generic validation error)
  notMatch,
}

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPasswordInput.pure({this.password = 'pure'}) : super.pure('');

  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// Password to compare with
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return password == value ? null : ConfirmPasswordValidationError.notMatch;
  }
}
