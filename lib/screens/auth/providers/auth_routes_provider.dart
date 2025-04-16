import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_state.dart';
import '../providers/auth_provider.dart';

part 'auth_routes_provider.g.dart';

// A provider that handles auth-related navigation logic
@riverpod
class AuthRouteHandler extends _$AuthRouteHandler {
  @override
  void build() {
    // This provider doesn't need to return a value, it just observes auth state
    // and performs navigation
    ref.listen(authProvider, (previous, next) {
      _handleAuthStateChange(next);
    });

    return;
  }

  void _handleAuthStateChange(AuthState state) {
    if (state is AuthStateAuthenticated) {
      _navigateTo('/');
    } else if (state is AuthStateGoogleRegistration) {
      _navigateTo('/auth/google-signup');
    } else if (state is AuthStateUnauthenticated) {
      // Optional: navigate to login page when logged out
      // _navigateTo('/auth/login');
    }
  }

  void signUp(
    BuildContext context, {
    required String email,
    required String password,
    required String name,
    required bool termsAccepted,
    required bool passwordsMatch,
    String? phone,
  }) {
    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('signup.agreeTerms'.tr())),
      );
      return;
    }

    if (!passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('signup.passwordsDoNotMatch'.tr())),
      );
      return;
    }

    ref.read(authProvider.notifier).signUp(
          email,
          password,
          name,
          phone,
        );
  }

  void navigateToLogin(BuildContext context) {
    context.go('/auth/login');
  }

  void navigateToSignup(BuildContext context) {
    context.go('/auth/signup');
  }

  void _navigateTo(String route) {
    // Find the current BuildContext
    final context = _findNavigationContext();
    if (context != null) {
      GoRouter.of(context).go(route);
    }
  }

  BuildContext? _findNavigationContext() {
    // This is a simplified approach, ideally you would have a proper way to
    // access the navigation context
    // In a real app, consider using a GlobalKey or passing the context explicitly
    return null;
  }
}
