import 'package:equatable/equatable.dart';
import 'package:nws/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// initial state before anything happens
class AuthInitial extends AuthState {}

// state shown when some async auth process is happening
class AuthLoading extends AuthState {}

// state when the user is successfully logged in
class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// state when no user is logged in
class AuthUnauthenticated extends AuthState {}

// state when there was an error (like wrong password)
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
