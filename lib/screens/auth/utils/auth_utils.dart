import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/auth/models/auth_state.dart';

/// Auth state navigation helper
class AuthNavigationHelper {
  /// Handle common navigation based on auth state
  static void handleAuthStateNavigation(
    BuildContext context,
    WidgetRef ref,
    AuthState authState,
  ) {
    final isLoading = authState is AuthStateLoading;

    // Prevent back navigation when loading
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }

    // Navigate to home when authenticated
    if (authState is AuthStateAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
    }

    // Navigate to Google signup when in Google registration state
    if (authState is AuthStateGoogleRegistration) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/auth/google-signup');
      });
    }
  }

  /// Validate basic form fields
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    return password.length >= 6;
  }

  static bool validateName(String name) {
    return name.length >= 2;
  }

  static bool validatePhone(String phone) {
    return phone.isEmpty || phone.length >= 10;
  }
}
