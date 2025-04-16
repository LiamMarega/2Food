import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:snapfood/common/widgets/splash_page.dart';
import 'package:snapfood/screens/auth/models/auth_state.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';
import 'package:snapfood/screens/auth/routes/auth_routes.dart';
import 'package:snapfood/screens/events/routes/routes.dart';
import 'package:snapfood/screens/home/routes/home_routes.dart';
import 'package:snapfood/screens/orders/pages/orders_page.dart';
import 'package:snapfood/screens/payments/routes/payment_routes.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';
import 'package:snapfood/screens/profile/profile_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    refreshListenable: router,
    redirect: router._redirect,
    routes: router._routes,
    initialLocation: '/',
    debugLogDiagnostics: true,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
  final Ref _ref;

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);

    // Handle authenticated state
    final isAuth = authState is AuthStateAuthenticated;
    final isAuthPath = state.matchedLocation.startsWith('/auth');
    final isSplashPath = state.matchedLocation == '/splash';

    // If on splash and not loading anymore, redirect appropriately
    if (isSplashPath && authState is! AuthStateLoading) {
      return isAuth ? '/' : '/auth/welcome';
    }

    // If authenticated and trying to access auth pages, redirect to home
    if (isAuth && isAuthPath) {
      return '/';
    }

    // If not authenticated and trying to access protected routes, redirect to welcome
    if (!isAuth && !isAuthPath && !isSplashPath) {
      return '/auth/welcome';
    }

    // // Show splash screen while loading
    // if (authState is AuthStateLoading ) {
    //   return '/splash';
    // }

    // Otherwise, allow navigation
    return null;
  }

  List<RouteBase> get _routes => [
        // Splash route
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        ...authRoutes,
        // Add a separate route for the payment screen
        GoRoute(
          path: '/payment-process',
          name: 'payment',
          builder: (context, state) {
            final url = state.extra! as String;
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
            ...eventRoutes,
            GoRoute(
              path: '/search',
              builder: (context, state) => const Center(
                child: Text('Search Page'),
              ),
            ),
            GoRoute(
              path: '/orders',
              builder: (context, state) => const OrdersPage(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Center(
                child: ProfilePage(),
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
        child: const Icon(LucideIcons.venetianMask),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        blurEffect: true,
        icons: const [
          LucideIcons.house,
          LucideIcons.search,
          LucideIcons.receipt,
          LucideIcons.userRound,
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
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
