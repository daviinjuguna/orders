part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

final class SplashStart extends SplashEvent {}

final class _ReceivedAuth extends SplashEvent {
  _ReceivedAuth(this.user);

  final UserEntity user;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedAuth && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
