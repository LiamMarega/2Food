import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/approved_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/pending_screen.dart';
import 'package:snapfood/screens/payments/ui/page/payment_status/rejected_screen.dart';

final paymentRoutes = [
  GoRoute(
    path: 'payment',
    builder: (context, state) {
      final url = state.extra! as String;
      return PaymentScreen(url: url);
    },
  ),
  GoRoute(
    path: '/payment-status/approved',
    name: 'payment-approved',
    builder: (context, state) => const ApprovedScreen(),
  ),
  GoRoute(
    path: '/payment-status/pending',
    name: 'payment-pending',
    builder: (context, state) => const PendingScreen(),
  ),
  GoRoute(
    path: '/payment-status/rejected',
    name: 'payment-rejected',
    builder: (context, state) => const RejectedScreen(),
  ),
];
