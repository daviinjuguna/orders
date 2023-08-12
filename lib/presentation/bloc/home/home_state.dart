part of 'home_bloc.dart';

@immutable
class HomeState {
  final HomeStatus status;
  final HomeDisplay? display;
  final String? error;
  const HomeState({
    this.status = HomeStatus.initial,
    this.display,
    this.error,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.status == status &&
        other.display == display &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ display.hashCode ^ error.hashCode;

  HomeState copyWith({
    HomeStatus? status,
    HomeDisplay? display,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      display: display ?? this.display,
      error: error ?? this.error,
    );
  }
}

enum HomeStatus { initial, loading, success, failure }
