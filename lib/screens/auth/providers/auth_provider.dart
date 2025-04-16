import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../models/auth_state.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    // Always start with loading state
    _initialize();
    return const AuthStateLoading();
  }

  Future<void> _initialize() async {
    final session = Supabase.instance.client.auth.currentSession;

    // No session means no authenticated user
    if (session == null) {
      state = const AuthStateUnauthenticated();
      return;
    }

    // Check if user exists in the database
    try {
      final exist = await existUser(session.user.id);

      if (exist) {
        state = AuthStateAuthenticated(session.user);
      } else {
        state = const AuthStateUnauthenticated();
      }
    } catch (e) {
      log('Error checking user existence: $e', error: e);
      state = AuthStateError(e.toString());
    }

    // Set up auth state change listener
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      // Handle different auth events
      switch (event) {
        case AuthChangeEvent.signedIn:
          _handleSignIn(session);
        case AuthChangeEvent.signedOut:
          state = const AuthStateUnauthenticated();
        case AuthChangeEvent.tokenRefreshed:
        case AuthChangeEvent.userUpdated:
          if (session != null) {
            state = AuthStateAuthenticated(session.user);
          }
        default:
          // No-op for other events
          break;
      }
    });
  }

  Future<void> _handleSignIn(Session? session) async {
    if (session == null) {
      state = const AuthStateUnauthenticated();
      return;
    }

    state = const AuthStateLoading();

    try {
      final exist = await existUser(session.user.id);

      if (exist) {
        state = AuthStateAuthenticated(session.user);
      } else {
        // User authenticated but not in database - needs registration
        state = AuthStateGoogleRegistration(
          id: session.user.id,
          email: session.user.email ?? '',
          name: session.user.userMetadata?['full_name']?.toString() ?? '',
          photoUrl: session.user.userMetadata?['avatar_url']?.toString() ?? '',
          googleAuthToken: session.providerToken ?? '',
          googleIdToken: session.providerRefreshToken ?? '',
          phone: session.user.phone,
        );
      }
    } catch (e) {
      log('Error during sign in: $e', error: e);
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
      log('Error fetching user: $e');
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
      log('Error checking if user exists: $e', error: e);
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
