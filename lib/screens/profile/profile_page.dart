import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ShadButton.secondary(
          child: const Text('Cerrar sesión'),
          onTapUp: (value) {
            ref.read(authSocialProvider.notifier).logout();
          },
        );
      },
    );
  }
}
