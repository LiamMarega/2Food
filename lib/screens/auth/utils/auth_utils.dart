import 'package:flutter/material.dart';

/// Auth utilities helper class
class AuthUtils {
  /// Block back navigation during loading
  static void preventBackNavigation(BuildContext context, bool isLoading) {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  /// Validate email format
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  static bool validatePassword(String password) {
    return password.length >= 6;
  }

  /// Validate name
  static bool validateName(String name) {
    return name.length >= 2;
  }

  /// Validate phone number
  static bool validatePhone(String phone) {
    return phone.isEmpty || phone.length >= 10;
  }
}
