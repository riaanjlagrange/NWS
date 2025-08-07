import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    // App launch event: check if the user is already signed in
    on<AppStarted>((event, emit) async {
      final isLoggedIn = _authService.isLoggedIn();

      if (isLoggedIn) {
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Handle user sign-in
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await _authService.signIn(email: event.email, password: event.password);
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle user sign-up
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signUp(
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle user sign-out
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _authService.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
