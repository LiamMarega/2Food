import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/events.dart';

class EventHomePage extends StatelessWidget {
  const EventHomePage({
    required this.event,
    super.key,
  });

  final Event event;

  LatLng _getEventLocation() {
    if (event.location_coordinates != null) {
      final lat =
          double.tryParse(event.location_coordinates!['latitude'].toString()) ??
              0.0;
      final lng = double.tryParse(
            event.location_coordinates!['longitude'].toString(),
          ) ??
          0.0;

      return LatLng(lat, lng);
    }
    return const LatLng(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      LucideIcons.moveLeft,
                      fill: 1,
                      weight: 800,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.go('/');
                    },
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  LucideIcons.share2,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ],
            expandedHeight: 300,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'event-${event.id}',
                    child: event.banner != null && event.banner!.isNotEmpty
                        ? Image.network(
                            event.banner!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.2),
                                child: Center(
                                  child: Icon(
                                    LucideIcons.venetianMask,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 48,
                                  ),
                                ),
                              );
                            },
                          )
                        : ColoredBox(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.2),
                            child: Center(
                              child: Icon(
                                LucideIcons.venetianMask,
                                color: Theme.of(context).colorScheme.primary,
                                size: 48,
                              ),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Stack(
                    children: [
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price section
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 24),

                  // Available spots section
                  if (event.max_users != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'eventHomePage.availableSpots'.tr(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getAvailabilityColor(
                              context,
                              event.max_users!,
                              event.users_joined,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_getRemainingSpots(event.max_users!, event.users_joined)}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // About the event
                  Text(
                    'eventHomePage.aboutEvent'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 32),

                  // Location map section
                  if (event.location_coordinates != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.is_secret_location == true
                              ? 'eventHomePage.secretLocation'.tr()
                              : 'eventHomePage.location'.tr(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (event.is_secret_location == false &&
                            event.location != null)
                          Text(
                            event.location!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                          ),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: _getEventLocation(),
                                initialZoom: 15,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: _getEventLocation(),
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        LucideIcons.mapPin,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Event details section
                  if (event.tags != null && event.tags!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'eventHomePage.eventDetails'.tr(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.tags!.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.1),
                              side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.2),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Secret menu notice
                  if (event.secret_menu == true)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.utensils,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'eventHomePage.secretMenu'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'eventHomePage.secretMenuDescription'.tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Secret attendees notice
                  if (event.secret_attendees == true)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.users,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'eventHomePage.secretAttendees'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'eventHomePage.secretAttendeesDescription'
                                      .tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${event.price?.toStringAsFixed(0) ?? '0'}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/persona',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: _isEventFull(event) || _isEventPast(event)
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('eventHomePage.joinEvent'.tr()),
                            ),
                          );
                        },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(150, 48),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Reserva tu lugar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isEventFull(Event event) {
    if (event.max_users == null || event.users_joined == null) return false;
    return event.users_joined! >= event.max_users!;
  }

  bool _isEventPast(Event event) {
    return event.date.isBefore(DateTime.now());
  }

  String _getButtonText(Event event) {
    if (_isEventPast(event)) {
      return 'eventHomePage.eventEnded'.tr();
    }
    if (_isEventFull(event)) {
      return 'eventHomePage.noSpotsAvailable'.tr();
    }
    if (event.price != null && event.price! > 0) {
      return '${'eventHomePage.reserveFor'.tr()} \$${event.price}';
    }
    return 'eventHomePage.joinEvent'.tr();
  }

  int _getRemainingSpots(int maxUsers, int? usersJoined) {
    if (usersJoined == null) return maxUsers;
    return maxUsers - usersJoined;
  }

  Color _getAvailabilityColor(
    BuildContext context,
    int maxUsers,
    int? usersJoined,
  ) {
    final remaining = _getRemainingSpots(maxUsers, usersJoined);
    final ratio = remaining / maxUsers;

    if (ratio <= 0.2) {
      return Theme.of(context).colorScheme.error;
    } else if (ratio <= 0.5) {
      return Theme.of(context).colorScheme.error.withValues(alpha: 0.7);
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }
}
