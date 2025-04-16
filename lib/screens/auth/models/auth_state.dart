import 'package:supabase_flutter/supabase_flutter.dart';

/// Base class for all authentication states
sealed class AuthState {
  const AuthState();
}

/// State when authentication is in progress (loading)
class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

/// State when user is authenticated
class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated(this.user);
  final User user;
}

/// State when user is not authenticated
class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

/// State when authentication error occurs
class AuthStateError extends AuthState {
  const AuthStateError(this.message);
  final String message;
}

/// State during Google registration process
class AuthStateGoogleRegistration extends AuthState {
  const AuthStateGoogleRegistration({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.googleAuthToken,
    required this.googleIdToken,
    this.phone,
  });

  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String? phone;
  final String googleAuthToken;
  final String googleIdToken;
}
