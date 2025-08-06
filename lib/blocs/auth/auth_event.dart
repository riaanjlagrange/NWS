import 'package:equatable/equatable.dart';

// define events that the authbloc will react to
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// triggered when the app starts to check if a user is logged in
class AppStarted extends AuthEvent {}

// triggered when user attempts to sign in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// triggered when user attempt to sign up
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequested(this.email, this.password, this.confirmPassword);
}

// triggered when the user wants to log out
class SignOutRequested extends AuthEvent {}
