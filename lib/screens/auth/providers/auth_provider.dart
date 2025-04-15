import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
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

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    _initialize();
    final session = Supabase.instance.client.auth.currentSession;

    // Start with unauthenticated, then check in _initialize
    if (session != null) {
      // Fetch user existence asynchronously
      _checkExistence(session.user.id);
      return const AuthStateLoading();
    }
    return const AuthStateUnauthenticated();
  }

  Future<void> _initialize() async {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;
      bool exist;
      exist = false;
      if (session != null) {
        exist = await existUser(session.user.id);
      }
      switch (event) {
        case AuthChangeEvent.initialSession:
          if (session != null && exist) {
            state = AuthStateAuthenticated(session.user);
          } else {
            state = const AuthStateUnauthenticated();
          }
        case AuthChangeEvent.signedIn:
          if (session != null && exist) {
            state = AuthStateAuthenticated(session.user);
          }
          if (session != null && !exist) {
            state = AuthStateGoogleRegistration(
              id: session.user.id,
              email: session.user.email ?? '',
              name: session.user.userMetadata?['full_name']?.toString() ?? '',
              photoUrl:
                  session.user.userMetadata?['avatar_url']?.toString() ?? '',
              googleAuthToken: session.providerToken ?? '',
              googleIdToken: session.providerRefreshToken ?? '',
              phone: session.user.phone,
            );
          } else {
            state = const AuthStateLoading();
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

  Future<void> _checkExistence(String userId) async {
    try {
      final exist = await existUser(userId);
      final session = Supabase.instance.client.auth.currentSession;

      if (session != null && exist) {
        state = AuthStateAuthenticated(session.user);
      } else {
        state = const AuthStateUnauthenticated();
      }
    } catch (e) {
      state = AuthStateError(e.toString());
    }
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

  Future<void> signUp(
    String email,
    String password,
    String name,
    String? phone,
  ) async {
    state = const AuthStateLoading();
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
          if (phone != null && phone.isNotEmpty) 'phone': phone,
        },
      );

      if (response.user != null) {
        state = AuthStateAuthenticated(response.user!);
      } else {
        // In case the signup requires email confirmation
        state = const AuthStateUnauthenticated();
      }
    } on AuthException catch (e) {
      state = AuthStateError(e.message);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future<void> googleLogin() async {
    state = const AuthStateLoading();
    try {
      const iosClientId =
          '212712903666-4sgkak0hsbak0v93g9pcgo7j89b7pejj.apps.googleusercontent.com';
      const webClientId =
          '212712903666-2f39ighj9c61668goh3vls2qiu7cec9o.apps.googleusercontent.com';

      final googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
        scopes: ['email', 'profile'],
      );

      // Sign in with Google
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        state = const AuthStateUnauthenticated();
        return;
      }

      // Get Google authentication data
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        state = const AuthStateError('Could not get ID token from Google');
        return;
      }

      state = AuthStateGoogleRegistration(
        id: '',
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        photoUrl: googleUser.photoUrl ?? '',
        phone: '',
        googleAuthToken: accessToken ?? '',
        googleIdToken: idToken,
      );
    } on AuthException catch (e) {
      state = AuthStateError(e.message);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future<void> googleSignUp() async {
    state = const AuthStateLoading();
    try {
      const iosClientId =
          '212712903666-4sgkak0hsbak0v93g9pcgo7j89b7pejj.apps.googleusercontent.com';
      const webClientId =
          '212712903666-2f39ighj9c61668goh3vls2qiu7cec9o.apps.googleusercontent.com';

      final googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
        scopes: ['email', 'profile'],
      );

      // Sign in with Google
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        state = const AuthStateUnauthenticated();
        return;
      }

      // Get Google authentication data
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        state = const AuthStateError('Could not get ID token from Google');
        return;
      }

      final supabase = Supabase.instance.client;

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
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

  Future<User?> findUser(String userId) async {
    try {
      final supabase = Supabase.instance.client;
      final response =
          await supabase.from('users').select().eq('id', userId).single();

      return User.fromJson(response);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<bool> existUser(String userId) async {
    try {
      final supabase = Supabase.instance.client;
      final response =
          await supabase.from('users').select().eq('id', userId).single();

      log(response.toString());

      return response != null;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  Future<void> saveUser({
    required String id,
    required String name,
    required String email,
    String? photo,
    String? phone,
    int points = 0,
    String role = 'CUSTOMER',
  }) async {
    state = const AuthStateLoading();
    try {
      final supabase = Supabase.instance.client;

      await supabase.from('users').upsert({
        'id': id,
        'email': email,
        'name': name,
        'photo': photo,
        'points': points,
        'phone': phone,
        'role': role,
        'created_at': DateTime.now().toIso8601String(),
      });

      // After successfully saving the user, update the state
      final user = await findUser(id);
      if (user != null) {
        state = AuthStateAuthenticated(user);
      } else {
        state = const AuthStateError('Failed to retrieve saved user');
      }
    } catch (e) {
      state = AuthStateError('Error saving user: $e');
    }
  }
}
