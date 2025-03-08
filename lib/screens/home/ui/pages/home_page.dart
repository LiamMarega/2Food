import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/utils/media_query.dart';
import 'package:snapfood/screens/home/ui/pages/restaurant_detail.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';
import 'package:snapfood/screens/home/ui/widgets/category_tabs.dart';
import 'package:snapfood/screens/home/ui/widgets/menu_grid.dart';
import 'package:snapfood/screens/home/ui/widgets/promo_banner.dart';
import 'package:snapfood/screens/home/ui/widgets/upcoming_events.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Using a dark grey color instead of black
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            return true;
          },
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverPadding(padding: EdgeInsets.all(20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const <String>[];
                      }
                      // Combined list of food and restaurants in Spanish
                      final searchOptions = [
                        // Foods
                        'Pizza',
                        'Hamburguesa',
                        'Pasta',
                        'Sushi',
                        'Tacos',
                        'Ensalada',
                        'Bistec',
                        'Mariscos',
                        'Vegetariano',
                        'Postre',
                        // Restaurants
                        'La Parrilla',
                        'El Rincón Mexicano',
                        'Sabor Italiano',
                        'Sushi Express',
                        'Burger King',
                        'La Casa de las Enchiladas',
                        'El Asador',
                        'Mariscos del Puerto',
                        'Vegetariano Saludable',
                        'Dulce Tentación',
                      ];
                      return searchOptions.where((option) {
                        return option.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            );
                      });
                    },
                    fieldViewBuilder: (
                      context,
                      textEditingController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      return ShadInput(
                        controller: textEditingController,
                        focusNode: focusNode,
                        placeholder: const Text(
                          'Search for food or restaurants...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        prefix: const Icon(Icons.search),
                        onChanged: (value) {},
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4,
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            height: min(options.length * 48, 200),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                // Determine if this is a food or restaurant (simplified approach)
                                final isRestaurant = [
                                  'La Parrilla',
                                  'El Rincón Mexicano',
                                  'Sabor Italiano',
                                  'Sushi Express',
                                  'Burger King',
                                  'La Casa de las Enchiladas',
                                  'El Asador',
                                  'Mariscos del Puerto',
                                  'Vegetariano Saludable',
                                  'Dulce Tentación',
                                ].contains(option);

                                return ListTile(
                                  leading: Icon(
                                    isRestaurant
                                        ? Icons.restaurant
                                        : Icons.fastfood,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(option),
                                  subtitle: Text(
                                    isRestaurant ? 'Restaurant' : 'Food',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  onTap: () {
                                    onSelected(option);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Space after search bar
              SliverToBoxAdapter(
                child: SizedBox(height: mediaHeight(context, 0.05)),
              ),
              // Main content container
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PromoBanner(),
                      const SizedBox(height: 16),
                      ColoredBox(
                        color: Theme.of(context).colorScheme.surface,
                        child: const CategoryTabs(),
                      ),
                    ],
                  ),
                ),
              ),
              // Content based on loading state
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        MenuCarousel(items: homeState.promotions ?? []),
                        const UpcomingEvents(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselPromotions extends ConsumerWidget {
  const CarouselPromotions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotions =
        ref.watch(homeProvider.select((state) => state.promotions)) ?? [];

    return SizedBox(
      height: mediaHeight(context, 0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: promotions.length,
        itemBuilder: (context, idx) {
          final promotion = promotions[idx];
          return FoodCard(
            key: Key('promotion-${promotion.id}'),
            product: promotion,
          );
        },
      ),
    );
  }
}

class CarouselRecommended extends StatefulWidget {
  const CarouselRecommended({super.key});

  @override
  State<CarouselRecommended> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselRecommended> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Fixed height for the carousel
      child: ListView(
        physics:
            const NeverScrollableScrollPhysics(), // Prevent ListView scroll
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Consumer(
              builder: (context, ref, child) {
                final restaurants = ref
                    .watch(homeProvider.select((state) => state.restaurants));
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
                  children: restaurants
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
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: ShadTheme.of(context).colorScheme.primary,
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(5, 15),
            ),
          ],
        ),
        width: width * 7 / 8,
        child: GestureDetector(
          onTap: () {
            print('tapped');
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(-5, -5),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                color: Theme.of(context).cardColor.withValues(alpha: 0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color:
                        Theme.of(context).dividerColor.withValues(alpha: 0.2),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          restaurant.image,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    required this.index,
    required this.label,
    super.key,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length]
          .withValues(alpha: 0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}
