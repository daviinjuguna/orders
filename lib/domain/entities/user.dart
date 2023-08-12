import 'package:order_app/data/data.dart';

class UserEntity {
  final String uid;
  final String? email;
  final AuthStatus status;

  UserEntity._({
    required this.uid,
    this.email,
    required this.status,
  });

  factory UserEntity.fromModel(UserModel model) => UserEntity._(
      uid: model.uid, email: model.email, status: AuthStatus.initial);

  UserEntity.initial() : this._(uid: '', status: AuthStatus.initial);

  UserEntity.authenticated({
    required String uid,
    required String email,
  }) : this._(uid: uid, email: email, status: AuthStatus.authenticated);

  UserEntity.unauthenticated()
      : this._(uid: '', status: AuthStatus.unauthenticated);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity && other.uid == uid && other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
  @override
  String toString() {
    return 'Status: $status';
  }
}

extension UserEntityX on UserEntity {
  UserModel toModel() {
    return UserModel(
      uid: uid,
      email: email,
    );
  }
}

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
}
