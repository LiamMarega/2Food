import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildWelcomeCard(context, theme),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          _buildWelcomeTitle(theme),
          const SizedBox(height: 30),
          _buildAppLogo(context),
          const Spacer(),
          _buildSubtitle(theme),
          _buildNavigationButton(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeTitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'welcome.title'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'welcome.appName'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Positioned(
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/food_scene.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'welcome.subtitle'.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'welcome.signInPrompt'.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => context.go('/auth/signup'),
          child: Container(
            width: 70,
            height: 140,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
