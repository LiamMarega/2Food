import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/payments/ui/page/auth_webview_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/approved_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/pending_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/rejected_screen.dart';

final paymentRoutes = [
  GoRoute(
    path: 'mercadopago/auth-webview',
    builder: (context, state) {
      final url = state.uri.queryParameters['url'];
      return AuthWebViewScreen(url: url);
    },
  ),
  GoRoute(
    path: 'payment',
    builder: (context, state) => PaymentScreen(
      url: state.uri.queryParameters['url'],
    ),
    routes: [
      GoRoute(
        path: 'approved',
        builder: (context, state) => const ApprovedScreen(),
      ),
      GoRoute(
        path: 'pending',
        builder: (context, state) => const PendingScreen(),
      ),
      GoRoute(
        path: 'rejected',
        builder: (context, state) => const RejectedScreen(),
      ),
    ],
  ),
];
