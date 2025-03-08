import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';
import 'package:snapfood/screens/auth/routes/auth_routes.dart';
import 'package:snapfood/screens/home/routes/home_routes.dart';
import 'package:snapfood/screens/payments/routes/payment_routes.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    refreshListenable: router,
    redirect: router._redirect,
    routes: router._routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
  final Ref _ref;

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    final isAuth = switch (authState) {
      AuthStateAuthenticated() => true,
      _ => false,
    };

    final isLoggingIn = state.matchedLocation == '/login';

    if (!isAuth && !isLoggingIn) return '/login';
    if (isAuth && isLoggingIn) return '/';
    return null;
  }

  List<RouteBase> get _routes => [
        ...authRoutes,
        // Add a separate route for the payment screen
        GoRoute(
          path: '/payment-process',
          name: 'payment',
          builder: (context, state) {
            final url = state.extra as String;
            return PaymentScreen(url: url);
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            ...homeRoutes,
            ...paymentRoutes,
            GoRoute(
              path: '/search',
              builder: (context, state) => const Center(
                child: Text('Search Page'),
              ),
            ),
            GoRoute(
              path: '/orders',
              builder: (context, state) => const Center(
                child: Text('Orders Page'),
              ),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Center(
                child: Text('Profile Page'),
              ),
            ),
          ],
        ),
      ];
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.question_mark_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        blurEffect: true,
        icons: const [
          Icons.home_outlined,
          Icons.search_outlined,
          Icons.receipt_long_outlined,
          Icons.person_outline,
        ],
        activeIndex: _calculateSelectedIndex(context),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
            case 1:
              context.go('/search');
            case 2:
              context.go('/orders');
            case 3:
              context.go('/profile');
          }
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.onSurfaceVariant,
        splashColor:
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        splashSpeedInMilliseconds: 300,
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    if (location == '/search') return 1;
    if (location == '/orders') return 2;
    if (location == '/profile') return 3;
    return 0;
  }
}
