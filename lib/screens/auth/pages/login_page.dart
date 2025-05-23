import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/screens/auth/components/auth_components.dart';

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: AuthScaffold(
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
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password field
                  AuthTextField(
                    controller: passwordController,
                    labelText: 'login.password'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 50),

                  // Google sign-in button
                  const GoogleSignInButton(),
                ],
              ),
            ),

            const Spacer(),

            // Login button
            AuthBottomActionContainer(
              buttonText: 'login.login'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
