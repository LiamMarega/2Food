import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/screens/auth/components/auth_components.dart';

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
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
          CircleAvatar(
            radius: 40,
            backgroundImage: const NetworkImage('authState.photoUrl'),
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
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
