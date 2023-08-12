part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class WatchHomeDisplay extends HomeEvent {}

class _ReceivedHomeDisplay extends HomeEvent {
  final Either<String, HomeDisplay> display;
  _ReceivedHomeDisplay(this.display);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedHomeDisplay && other.display == display;
  }

  @override
  int get hashCode => display.hashCode;
}
