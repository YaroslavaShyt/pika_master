import 'package:equatable/equatable.dart';

enum AuthStatus { loading, success, failure, initial }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
  });

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }

  final AuthStatus status;

  @override
  List<Object?> get props => [
        status,
      ];
}
