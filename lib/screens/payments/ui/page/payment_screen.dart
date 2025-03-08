import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/common/widgets/global_alert.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment-process';
  final String url;

  const PaymentScreen({super.key, required this.url});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    log("PaymentScreen initState called");
    log("URL: ${widget.url}");

    // Use a small delay to ensure the widget is fully built
    Future.microtask(() {
      _launchURL(context);
    });
  }

  Future<void> _launchURL(BuildContext context) async {
    log("Launching URL: ${widget.url}");

    try {
      await launchUrl(
        Uri.parse(widget.url),
        prefersDeepLink: true,
        customTabsOptions: CustomTabsOptions(
          instantAppsEnabled: true,
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: Theme.of(context).colorScheme.surface,
          ),
          shareState: CustomTabsShareState.off,
          urlBarHidingEnabled: false,
          showTitle: false,
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
          animations: const CustomTabsAnimations(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,
            fallbackCustomTabs: ['com.android.chrome'],
          ),
        ),
      );
    } catch (e) {
      log('Error launching URL: $e');
      if (!mounted) return;

      GlobalAlert.showError(context, 'Error al abrir el navegador: $e');
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("PaymentScreen build method called");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procesando pago'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text('Abriendo pasarela de pago...'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
