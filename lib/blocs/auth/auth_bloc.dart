import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/models/user_model.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    // App launch event: check if the user is already signed in
    on<AppStarted>((event, emit) async {
      // if user is already logged in
      if (_authService.isLoggedIn()) {
        // get their uid
        final uid = _authService.currentUserUid();

        try {
          // try to get their user data stored in firestore
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();

          // if the user exists in firestore
          if (doc.exists) {
            // conver user data to usermodel
            final user = UserModel.fromMap(uid, doc.data()!);

            // pass the user data with the state
            emit(AuthAuthenticated(user));
          } else {
            // set state to unauthenticated
            emit(AuthUnauthenticated());
          }
        } catch (e) {
          emit(AuthError(e.toString()));
        }
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Handle user sign-in
    on<SignInRequested>((event, emit) async {
      // set state to loading
      emit(AuthLoading());

      try {
        // try to sign user in and save user
        final user = await _authService.signIn(
          email: event.email,
          password: event.password,
        );

        // then pass user with the state
        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle user sign-up
    on<SignUpRequested>((event, emit) async {
      // set state to loading
      emit(AuthLoading());

      try {
        // try to sign user up and save user
        final user = await _authService.signUp(
          username: event.username,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        // pass user with state
        emit(AuthAuthenticated(user));
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
