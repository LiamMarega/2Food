import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/events.dart';
import 'package:go_router/go_router.dart';

class EventHomePage extends StatelessWidget {
  const EventHomePage({
    required this.event,
    super.key,
  });

  final Event event;

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
              Spacer(),
              IconButton(
                icon: const Icon(
                  LucideIcons.share2,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ],
            expandedHeight: 350,
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
                  child: Container(
                    height: 33,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                  ),
                  bottom: -7,
                  left: 0,
                  right: 0,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price section

                    const SizedBox(height: 24),

                    // Available spots section
                    if (event.max_users != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'eventHomePage.availableSpots'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getAvailabilityColor(context,
                                  event.max_users!, event.users_joined),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${_getRemainingSpots(event.max_users!, event.users_joined)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
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

                    // Location section
                    if (event.location != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.is_secret_location == true
                                ? 'eventHomePage.secretLocation'.tr()
                                : 'eventHomePage.location'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  event.is_secret_location == true
                                      ? LucideIcons.lock
                                      : LucideIcons.mapPin,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.is_secret_location == true
                                            ? 'eventHomePage.locationReveal'
                                                .tr()
                                            : event.location!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      if (event.is_secret_location == true)
                                        Text(
                                          'eventHomePage.exactLocationReveal'
                                              .tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FilledButton(
            onPressed: _isEventFull(event) || _isEventPast(event)
                ? null
                : () {
                    // TODO: Implement joining the event
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('eventHomePage.joinEvent'.tr()),
                      ),
                    );
                  },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: Text(
              _getButtonText(event),
              style: const TextStyle(fontSize: 16),
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
      BuildContext context, int maxUsers, int? usersJoined) {
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
