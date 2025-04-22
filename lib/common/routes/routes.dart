import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:snapfood/common/widgets/splash_page.dart';
import 'package:snapfood/screens/auth/routes/auth_routes.dart';
import 'package:snapfood/screens/events/routes/routes.dart';
import 'package:snapfood/screens/home/routes/home_routes.dart';
import 'package:snapfood/screens/orders/pages/orders_page.dart';
import 'package:snapfood/screens/payments/routes/payment_routes.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';
import 'package:snapfood/screens/profile/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Class that listens to auth state changes
class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    _initialize();
  }

  void _initialize() {
    // Listen to auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      // Notify listeners when sign in, sign out, or token refresh happens
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.signedOut ||
          event == AuthChangeEvent.tokenRefreshed) {
        notifyListeners();
      }
    });
  }

  // Check if user is logged in
  bool get isLoggedIn => Supabase.instance.client.auth.currentUser != null;
}

class RouterNotifier extends ChangeNotifier {
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

final authNotifierProvider = Provider((ref) => AuthNotifier());

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();
  final authNotifier = ref.watch(authNotifierProvider);

  return GoRouter(
    refreshListenable: authNotifier,
    routes: router._routes,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authNotifier.isLoggedIn;
      final isGoingToAuth = state.fullPath?.startsWith('/auth') ?? false;
      final isGoingToSplash = state.fullPath == '/splash';

      // If the user is at splash, redirect based on authentication status after loading
      if (isGoingToSplash) {
        // Small delay to allow splash to be visible briefly - not actually needed in redirect
        // The actual redirect will happen immediately
        return isLoggedIn ? '/' : '/auth/welcome';
      }

      // If not logged in and not going to auth pages, redirect to welcome page
      if (!isLoggedIn && !isGoingToAuth) {
        return '/auth/welcome';
      }

      // If logged in and going to auth pages, redirect to home
      if (isLoggedIn && isGoingToAuth) {
        return '/';
      }

      // Allow the current navigation
      return null;
    },
  );
});
