import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/auth/pages/login_page.dart';
import 'package:snapfood/screens/auth/providers/auth_provider.dart';
import 'package:snapfood/screens/home/ui/pages/home_page.dart';

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
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/search',
              builder: (context, state) => const Center(
                child: Text('Search Page'),
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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
            case 1:
              context.go('/search');
            case 2:
              context.go('/profile');
          }
        },
        selectedIndex: _calculateSelectedIndex(context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    if (location == '/search') return 1;
    if (location == '/profile') return 2;
    return 0;
  }
}
