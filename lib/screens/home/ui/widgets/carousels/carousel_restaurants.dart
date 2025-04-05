import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';

class CarouselRestaurants extends StatefulWidget {
  const CarouselRestaurants({super.key});

  @override
  State<CarouselRestaurants> createState() => _CarouselRestaurantsState();
}

class _CarouselRestaurantsState extends State<CarouselRestaurants> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          height: 300, // Fixed height for the carousel
          child: ListView(
            physics:
                const NeverScrollableScrollPhysics(), // Prevent ListView scroll
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Consumer(
                  builder: (context, ref, child) {
                    final restaurants = ref.watch(
                        homeProvider.select((state) => state.restaurants));
                    return CarouselView.weighted(
                      controller: controller,
                      itemSnapping: true,
                      flexWeights: const <int>[1, 7, 1],
                      onTap: (index) {
                        context.go(
                          '/restaurant/${restaurants?[index].id}',
                          extra: restaurants?[index],
                        );
                      },
                      children:
                          [...?restaurants, ...?restaurants, ...?restaurants]
                                  ?.map(
                                    (e) => HeroLayoutCard(restaurant: e),
                                  )
                                  .toList() ??
                              [],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({
    required this.restaurant,
    super.key,
  });

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Hero(
      tag: 'restaurant-${restaurant.id}',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
        ),
        width: width * 7 / 8,
        child: GestureDetector(
          onTap: () {
            context.go(
              '/restaurant/${restaurant.id}',
              extra: restaurant,
            );
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(0.1),
            alignment: FractionalOffset.center,
            child: Card(
              elevation: 0,
              color: Theme.of(context).cardColor.withValues(alpha: 0.8),
              shape: RoundedRectangleBorder(
                borderRadius: kDefaultBorderRadius,
                side: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: kDefaultBorderRadius,
                      child: Image.network(
                        restaurant.image,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  ),
                  SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 22,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            restaurant.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            restaurant.description ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.95),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
