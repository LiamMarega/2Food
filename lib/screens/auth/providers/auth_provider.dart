import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

@freezed
class AuthSocialState with _$AuthSocialState {
  factory AuthSocialState({
    String? error,
    @Default(false) bool canContinue,
    @Default(false) bool loading,
  }) = _AuthSocialState;
}

@Riverpod(keepAlive: true)
class AuthSocial extends _$AuthSocial {
  @override
  AuthSocialState build() {
    return AuthSocialState();
  }

  Future<void> googleSignUp() async {
    state = state.copyWith(loading: true);
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

      // Get Google authentication data
      final googleAuth = await googleUser?.authentication;
      final idToken = googleAuth?.idToken;
      final accessToken = googleAuth?.accessToken;

      if (idToken == null || accessToken == null) {
        state = state.copyWith(error: 'Could not get ID token from Google');
        return;
      }

      final supabase = Supabase.instance.client;

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final session = res.session;
      final user = res.user;

      if (user == null || session == null) {
        throw Exception('Error al iniciar sesión con Google');
      }

      final userData =
          await supabase.from('users').select().eq('id', user.id).maybeSingle();

      if (userData == null) {
        // 3. Si no existe, crear el registro en tu tabla
        await supabase.from('users').insert({
          'id': user.id,
          'email': user.email,
          'name': user.userMetadata?['full_name'] ?? googleUser?.displayName,
          'photo': user.userMetadata?['avatar_url'] ?? googleUser?.photoUrl,
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      state = state.copyWith(loading: false);
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<bool> userExist(String userId) async {
    state = state.copyWith(loading: true);
    try {
      final supabase = Supabase.instance.client;

      // Query the users table in the public schema to check if the user exists
      final response = await supabase
          .from('users')
          .select()
          .eq('id', userId)
          .limit(1)
          .maybeSingle();

      state = state.copyWith(loading: false);

      // If response is not null, the user exists
      return response != null;
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(loading: true);
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signOut();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
