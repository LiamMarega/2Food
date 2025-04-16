import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Shared container for all auth screens
class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? primaryColor;

  const AuthScaffold({
    super.key,
    required this.child,
    this.isLoading = false,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = primaryColor ?? Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background upper container
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.65,
            ),
            // Main content
            child,
            // Loading overlay
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.1),
                width: double.infinity,
                height: double.infinity,
              ),
          ],
        ),
      ),
    );
  }
}

/// Main auth container used for login/signup forms
class AuthFormContainer extends StatelessWidget {
  final List<Widget> children;
  final double? height;

  const AuthFormContainer({
    super.key,
    required this.children,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: height ?? MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(children: children),
      ),
    );
  }
}

/// Common styled text field for auth forms
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        hintStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}

/// Bottom action container for auth screens
class AuthBottomActionContainer extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String buttonText;
  final bool isLoading;
  final Widget? extraContent;

  const AuthBottomActionContainer({
    super.key,
    this.onButtonPressed,
    required this.buttonText,
    this.isLoading = false,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: extraContent != null
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: extraContent,
                ))
              : null,
        ),
        if (onButtonPressed != null)
          Positioned(
            top: -25,
            child: GestureDetector(
              onTap: isLoading ? null : onButtonPressed,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isLoading ? Colors.grey : Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Social login button (Google)
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Opacity(
        opacity: isLoading ? 0.7 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                )
              else
                const Icon(
                  Icons.g_mobiledata, // Replace with proper Google icon
                  color: Colors.red,
                ),
              const SizedBox(width: 10),
              Text(
                'login.signInWithGoogle'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Header for auth screens with title and subtitle
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
