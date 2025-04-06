import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';

class UpcomingEvents extends ConsumerWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final events = state.events;
    final isLoading = state.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Proximos Eventos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all events
                },
                child: const Text('Ver todos'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: isLoading || events == null
              ? _buildLoadingList()
              : events.isEmpty
                  ? _buildNoEventsMessage(context)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == events.length - 1 ? 0 : 16,
                          ),
                          child: EventCard(
                            title: event.name,
                            description: event.description,
                            date: DateFormat('MMM dd, yyyy, h:mm a')
                                .format(event.date.toLocal()),
                            seatsLeft: event.max_users != null &&
                                    event.users_joined != null
                                ? event.max_users! - event.users_joined!
                                : null,
                            imageUrl: event.banner ?? '',
                            price: event.price,
                            currency: event.currency ?? 'USD',
                            eventId: event.id,
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: index == 2 ? 0 : 16),
          child: const EventCardSkeleton(),
        );
      },
    );
  }

  Widget _buildNoEventsMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhosphorIcon(
            PhosphorIcons.calendar(),
            size: 48,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay eventos próximos',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class EventCardSkeleton extends StatelessWidget {
  const EventCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: kDefaultBorderRadius,
      ),
      child: Shimmer.fromColors(
        baseColor: colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: colorScheme.primary.withValues(alpha: 0.3),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: kDefaultBorderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 200,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 240,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 14,
                      width: 160,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 16,
                      width: 120,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final int? seatsLeft;
  final String imageUrl;
  final double? price;
  final String currency;
  final String? eventId;

  const EventCard({
    required this.title,
    required this.description,
    required this.date,
    required this.seatsLeft,
    required this.imageUrl,
    required this.price,
    required this.currency,
    required this.eventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Shimmer effect container (below)
        Container(
          width: 280,
          height: 300, // Ajusta esta altura según sea necesario
          decoration: BoxDecoration(
            borderRadius: kDefaultBorderRadius,
          ),
          child: Shimmer.fromColors(
            baseColor: colorScheme.primary.withValues(alpha: 0.1),
            highlightColor: colorScheme.primary.withValues(alpha: 0.5),
            period: const Duration(seconds: 5),
            direction: ShimmerDirection.ttb,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: kDefaultBorderRadius,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.5),
                  width: 3,
                ),
              ),
            ),
          ),
        ),

        // Actual content (above)
        Container(
          width: 280,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: kDefaultBorderRadius,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: kDefaultBorderRadius,
              side: BorderSide(
                color: colorScheme.primary.withValues(alpha: 0.1),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                context.push(
                  '/events/$eventId',
                  extra: {
                    'fullscreen': true,
                    'hideNavBar': true,
                  },
                );
              },
              splashColor: colorScheme.primary.withValues(alpha: 0.1),
              highlightColor: colorScheme.primary.withValues(alpha: 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'event-$eventId',
                        child: Image.network(
                          imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      if (seatsLeft != null && seatsLeft! <= 3)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Badge(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            label: Text(
                              '$seatsLeft Asientos Disponibles',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      // Price badge
                      if (price != null)
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              '20% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            PhosphorIcon(
                              PhosphorIcons.calendar(),
                              size: 16,
                              color: colorScheme.primary.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.7),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
