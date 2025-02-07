// ignore_for_file: no_default_cases

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

sealed class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated(this.user);
  final User user;
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

class AuthStateError extends AuthState {
  const AuthStateError(this.message);
  final String message;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    _initialize();
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      return AuthStateAuthenticated(session.user);
    }
    return const AuthStateUnauthenticated();
  }

  void _initialize() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      switch (event) {
        case AuthChangeEvent.initialSession:
          if (session != null) {
            state = AuthStateAuthenticated(session.user);
          } else {
            state = const AuthStateUnauthenticated();
          }
        case AuthChangeEvent.signedIn:
          if (session != null) {
            state = AuthStateAuthenticated(session.user);
          }
        case AuthChangeEvent.signedOut:
          state = const AuthStateUnauthenticated();
        case AuthChangeEvent.passwordRecovery:
          break;
        case AuthChangeEvent.tokenRefreshed:
          if (session != null) {
            state = AuthStateAuthenticated(session.user);
          }
        case AuthChangeEvent.userUpdated:
          if (session != null) {
            state = AuthStateAuthenticated(session.user);
          }
        case AuthChangeEvent.mfaChallengeVerified:
          // Manejar verificación MFA si lo implementas en el futuro
          break;
        default:
          state = const AuthStateUnauthenticated();
      }
    });
  }

  Future<void> login(String email, String password) async {
    state = const AuthStateLoading();
    try {
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      if (response.user != null) {
        state = AuthStateAuthenticated(response.user!);
      }
    } on AuthException catch (e) {
      state = AuthStateError(e.message);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      state = const AuthStateUnauthenticated();
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }
}
