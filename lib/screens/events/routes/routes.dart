import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/events/pages/event_home_page.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';

final List<RouteBase> eventRoutes = [
  GoRoute(
    path: '/events/:eventId',
    name: 'event-detail',
    pageBuilder: (context, state) {
      final eventId = state.pathParameters['eventId']!;

      // Get navigation options from extra
      final extra = state.extra as Map<String, dynamic>?;
      final fullscreen = extra?['fullscreen'] as bool? ?? false;

      // Find the event from the provider using the ID
      final container = ProviderScope.containerOf(context);
      final homeState = container.read(homeProvider);

      // Find the event from the loaded events
      final event = homeState.events?.firstWhere(
        (event) => event.id == eventId,
        orElse: () => throw Exception('Event not found'),
      );

      // If event is not found, show an error
      if (event == null) {
        return MaterialPage(
          child: Scaffold(
            appBar: AppBar(title: const Text('Event Not Found')),
            body: const Center(
              child: Text('The requested event could not be found.'),
            ),
          ),
        );
      }

      return CustomTransitionPage(
        key: state.pageKey,
        child: EventHomePage(event: event),
        fullscreenDialog: fullscreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
];
