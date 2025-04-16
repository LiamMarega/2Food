import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/screens/auth/components/auth_components.dart';
import 'package:snapfood/screens/auth/models/auth_state.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';
import 'package:snapfood/screens/auth/utils/auth_utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    ref.read(authProvider.notifier).login(
          emailController.text,
          passwordController.text,
        );
  }

  void _handleGoogleLogin() {
    ref.read(authProvider.notifier).googleLogin();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthStateLoading;

    // Handle navigation based on auth state
    AuthNavigationHelper.handleAuthStateNavigation(context, ref, authState);

    return PopScope(
      canPop: !isLoading,
      child: AuthScaffold(
        isLoading: isLoading,
        child: AuthFormContainer(
          height: MediaQuery.of(context).size.height * 0.7,
          children: [
            const SizedBox(height: 40),

            // Login header
            AuthHeader(
              title: 'login.welcomeBack'.tr(),
              subtitle: 'login.loginToContinue'.tr(),
            ),

            const SizedBox(height: 60),

            // Login form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // Email field
                  AuthTextField(
                    controller: emailController,
                    labelText: 'login.email'.tr(),
                    prefixIcon: Icons.email_outlined,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password field
                  AuthTextField(
                    controller: passwordController,
                    labelText: 'login.password'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 50),

                  // Google sign-in button
                  GoogleSignInButton(
                    onPressed: _handleGoogleLogin,
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

            const Spacer(),

            // Login button
            AuthBottomActionContainer(
              buttonText: 'login.login'.tr(),
              isLoading: isLoading,
              onButtonPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
