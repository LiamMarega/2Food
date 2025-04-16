import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/auth_components.dart';
import '../models/auth_state.dart';
import '../providers/auth_provider.dart';
import '../utils/auth_utils.dart';

class GoogleSignupPage extends ConsumerStatefulWidget {
  const GoogleSignupPage({super.key});

  @override
  ConsumerState<GoogleSignupPage> createState() => _GoogleSignupPageState();
}

class _GoogleSignupPageState extends ConsumerState<GoogleSignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with Google data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authProvider);
      if (authState is AuthStateGoogleRegistration) {
        nameController.text = authState.name;
        emailController.text = authState.email;
        phoneController.text = authState.phone ?? '';
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _handleCompleteRegistration(AuthStateGoogleRegistration authState) {
    ref.read(authProvider.notifier).saveUser(
          id: authState.id,
          name: nameController.text,
          email: emailController.text,
          photo: authState.photoUrl,
          phone: phoneController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthStateLoading;

    // Handle navigation based on auth state (now managed by the router)
    AuthUtils.preventBackNavigation(context, isLoading);

    // If state is not GoogleRegistration, navigation will be handled by the router
    if (authState is! AuthStateGoogleRegistration &&
        authState is! AuthStateLoading &&
        authState is! AuthStateAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/auth/login');
      });
    }

    return AuthScaffold(
      isLoading: isLoading,
      child: AuthFormContainer(
        height: MediaQuery.of(context).size.height * 0.8,
        children: [
          const SizedBox(height: 40),

          // Header
          AuthHeader(
            title: 'googleSignup.completeRegistration'.tr(),
            subtitle: 'googleSignup.verifyInformation'.tr(),
          ),

          const SizedBox(height: 40),

          // Profile photo
          if (authState is AuthStateGoogleRegistration)
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(authState.photoUrl),
              backgroundColor: Colors.grey.shade200,
            ),

          const SizedBox(height: 40),

          // Form fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // Name field
                AuthTextField(
                  controller: nameController,
                  labelText: 'googleSignup.fullName'.tr(),
                  prefixIcon: Icons.person_outline,
                  enabled: !isLoading,
                ),

                const SizedBox(height: 20),

                // Email field (disabled)
                AuthTextField(
                  controller: emailController,
                  labelText: 'googleSignup.email'.tr(),
                  prefixIcon: Icons.email_outlined,
                  enabled: false,
                ),

                const SizedBox(height: 20),

                // Phone field
                AuthTextField(
                  controller: phoneController,
                  labelText: 'googleSignup.phoneNumber'.tr(),
                  prefixIcon: Icons.phone_android,
                  enabled: !isLoading,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),

          // Error message
          if (authState is AuthStateError)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                authState.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          const Spacer(),

          // Complete registration button
          if (authState is AuthStateGoogleRegistration || isLoading)
            AuthBottomActionContainer(
              buttonText: 'googleSignup.completeButton'.tr(),
              isLoading: isLoading,
              extraContent: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (authState is AuthStateGoogleRegistration) {
                          _handleCompleteRegistration(authState);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isLoading ? Colors.grey : Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledForegroundColor: Colors.white.withOpacity(0.8),
                  disabledBackgroundColor: Colors.grey.shade400,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'googleSignup.completeButton'.tr(),
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
