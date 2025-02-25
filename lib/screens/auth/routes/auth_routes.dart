import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/auth/pages/login_page.dart';

final authRoutes = [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) =>
        const LoginPage(), // Change to SignupPage when created
  ),
];
