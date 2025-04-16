import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:snapfood/screens/auth/components/auth_components.dart';
import 'package:snapfood/screens/auth/models/auth_state.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';
import 'package:snapfood/screens/auth/providers/auth_routes_provider.dart';
import 'package:snapfood/screens/auth/utils/auth_utils.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool agreeWithTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    ref.read(authRouteHandlerProvider.notifier).signUp(
          context,
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          termsAccepted: agreeWithTerms,
          passwordsMatch:
              passwordController.text == confirmPasswordController.text,
        );
  }

  void _handleGoogleSignup() {
    ref.read(authProvider.notifier).googleSignUp();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
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

    // Navigate to Google signup page when in Google registration state
    if (authState is AuthStateGoogleRegistration) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/auth/google-signup');
      });
    }

    // Handle navigation based on auth state
    AuthNavigationHelper.handleAuthStateNavigation(context, ref, authState);

    return AuthScaffold(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: AuthFormContainer(
          height: MediaQuery.of(context).size.height * 0.8,
          children: [
            const SizedBox(height: 40),

            // Signup header
            AuthHeader(
              title: 'signup.createAccount'.tr(),
              subtitle: 'signup.signUpToContinue'.tr(),
            ),

            const SizedBox(height: 40),

            // Signup form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // Name field
                  AuthTextField(
                    controller: nameController,
                    labelText: 'signup.fullName'.tr(),
                    prefixIcon: Icons.person_outline,
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 15),

                  // Email field
                  AuthTextField(
                    controller: emailController,
                    labelText: 'signup.email'.tr(),
                    prefixIcon: Icons.email_outlined,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),

                  // Password field
                  AuthTextField(
                    controller: passwordController,
                    labelText: 'signup.password'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 15),

                  // Confirm password field
                  AuthTextField(
                    controller: confirmPasswordController,
                    labelText: 'signup.confirmPassword'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 30),

                  // Google sign up button
                  GoogleSignInButton(
                    onPressed: _handleGoogleSignup,
                    isLoading: isLoading,
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

            // Already have account row
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'signup.alreadyHaveAccount'.tr(),
                    style: ShadTheme.of(context).textTheme.large,
                  ),
                  GestureDetector(
                    onTap: isLoading ? null : () => context.go('/auth/login'),
                    child: Text(
                      'signup.login'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Terms and conditions + signup button
            AuthBottomActionContainer(
              buttonText: 'signup.signUp'.tr(),
              isLoading: isLoading,
              onButtonPressed: _handleSignup,
              extraContent: Positioned(
                bottom: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: agreeWithTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeWithTerms = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Text(
                      'signup.agreeTerms'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
