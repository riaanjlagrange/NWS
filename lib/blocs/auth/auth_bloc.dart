import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  // do this when the app starts
  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      // check if user is already logged in when the app starts
      final isLoggedIn = _authService.isLoggedIn();
      // if so
      if (isLoggedIn) {
        // set state to authenticated
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } else {
        // else set the state to unauthenticated
        emit(AuthUnauthenticated());
      }
    });

    // when the user tries to sign in
    on<SignInRequested>((event, emit) async {
      // show a loading indicator
      emit(AuthLoading());
      // check if authentication is successful
      final success = await _authService.signIn(
        email: event.email,
        password: event.password,
      );

      // if it is successful
      if (success) {
        // change state to authenticated
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } else {
        // else change the state to unauthenticated
        emit(AuthUnauthenticated());
      }
    });

    // when user tries to sign up
    on<SignUpRequested>((event, emit) async {
      // show loading indicator
      emit(AuthLoading());

      // try to sign user up with email and password
      final success = await _authService.signUp(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      // check if sign up was successful
      if (success) {
        // if so change state to authenticated
        emit(AuthAuthenticated(_authService.currentUserUid()));
      } else {
        // else change the state to an error
        emit(AuthError("Failed to sign up"));
        // do initial check (to redirect to a sign in page etc)
        emit(AuthInitial());
      }
    });

    // when user tries to sign out
    on<SignOutRequested>((event, emit) async {
      // sign the user out
      await _authService.signOut();
      // change state back to unauthenticated
      emit(AuthUnauthenticated());
      // do initial check (to redirect to a sign in page etc)
      emit(AuthInitial());
    });
  }
}
