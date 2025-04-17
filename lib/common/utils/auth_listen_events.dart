// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Listens to Supabase authentication state changes and handles different auth events
///
/// This function returns a subscription that should be canceled when no longer needed
/// using `authSubscription.cancel()`
Stream<AuthState> listenToAuthChanges() {
  final supabase = Supabase.instance.client;

  debugPrint('Setting up auth state change listener');

  return supabase.auth.onAuthStateChange.map((data) {
    final event = data.event;
    final session = data.session;

    debugPrint(
      'Auth event: $event, session: ${session != null ? 'active' : 'null'}',
    );

    switch (event) {
      case AuthChangeEvent.initialSession:
        debugPrint('Initial session established');
      case AuthChangeEvent.signedIn:
        debugPrint('User signed in');
      case AuthChangeEvent.signedOut:
        debugPrint('User signed out');
      case AuthChangeEvent.passwordRecovery:
        debugPrint('Password recovery initiated');
      case AuthChangeEvent.tokenRefreshed:
        debugPrint('Auth token refreshed');
      case AuthChangeEvent.userUpdated:
        debugPrint('User profile updated');
      case AuthChangeEvent.userDeleted:
        debugPrint('User account deleted');
      case AuthChangeEvent.mfaChallengeVerified:
        debugPrint('MFA challenge verified');
    }

    return data;
  });
}
