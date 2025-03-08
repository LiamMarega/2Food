import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebViewScreen extends StatefulWidget {
  static const String routeName = 'auth-webview';
  final String? url;

  const AuthWebViewScreen({super.key, this.url});

  @override
  State<AuthWebViewScreen> createState() => _AuthWebViewScreenState();
}

class _AuthWebViewScreenState extends State<AuthWebViewScreen> {
  late final WebViewController controller;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('Error: ${error.description}');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.liammarega.com/')) {
                final uri = Uri.parse(request.url);
                final code = uri.queryParameters['code'];
                if (code != null) {
                  debugPrint('Authorization code received: $code');
                  if (mounted) {
                    context.go('/');
                  }
                  return NavigationDecision.prevent;
                }
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(
          Uri.parse(widget.url!),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer APP_USR-12345678-031820-X-12345678',
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null) {
      return const Scaffold(
        body: Center(
          child: Text('No URL provided'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Authentication'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (progress < 1.0)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
        ],
      ),
    );
  }
}
