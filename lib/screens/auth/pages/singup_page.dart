import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:snapfood/screens/auth/components/auth_components.dart';

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

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: SingleChildScrollView(
        child: AuthFormContainer(
          height: MediaQuery.of(context).size.height * .8,
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
                  ),

                  const SizedBox(height: 15),

                  // Email field
                  AuthTextField(
                    controller: emailController,
                    labelText: 'signup.email'.tr(),
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),

                  // Password field
                  AuthTextField(
                    controller: passwordController,
                    labelText: 'signup.password'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 15),

                  // Confirm password field
                  AuthTextField(
                    controller: confirmPasswordController,
                    labelText: 'signup.confirmPassword'.tr(),
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),

                  // Google sign up button
                  const GoogleSignInButton(),
                ],
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
                    onTap: () => context.go('/auth/login'),
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
              extraContent: Row(
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
          ],
        ),
      ),
    );
  }
}
