import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/utils/media_query.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';
import 'package:snapfood/screens/home/ui/widgets/category_tabs.dart';
import 'package:snapfood/screens/home/ui/widgets/food_card.dart';
import 'package:snapfood/screens/home/ui/widgets/menu_grid.dart';
import 'package:snapfood/screens/home/ui/widgets/promo_banner.dart';
import 'package:snapfood/screens/home/ui/widgets/upcoming_events.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Header with user greeting and location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hola, Liam 👋',
                          style: theme.textTheme.p.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          LucideIcons.bell,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.destructive,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ShadInput(
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(LucideIcons.search, size: 16),
                ),
                suffix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(LucideIcons.x, size: 16),
                ),
                placeholder:
                    Text('Search any...', style: theme.textTheme.muted),
                decoration: ShadDecoration(
                  border: ShadBorder(radius: BorderRadius.circular(24)),
                  color: Colors.white,
                ),
              ),
            ),

            // Main content with white background
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promotion Banner (Limited Time Offer)
                      Container(
                        margin: const EdgeInsets.all(16),
                        // height: 160,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            // Left side content (text)
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '40% Off',
                                      style: theme.textTheme.h1.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Limited Time Offer!',
                                      style: theme.textTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Enjoy a fantastic 40% discount from us!',
                                      style: theme.textTheme.p.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Just for you 🙂',
                                      style: theme.textTheme.p.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right side content (image)
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Icon(
                                    LucideIcons.pizza,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Category buttons (horizontal scrolling)
                      SizedBox(
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildCategoryButton(
                                icon: LucideIcons.coffee,
                                label: 'Coffee',
                                theme: theme,
                              ),
                              _buildCategoryButton(
                                icon: LucideIcons.cookie,
                                label: 'Snack',
                                theme: theme,
                              ),
                              _buildCategoryButton(
                                icon: LucideIcons.store,
                                label: 'Cafe',
                                theme: theme,
                              ),
                              _buildCategoryButton(
                                icon: LucideIcons.percent,
                                label: 'Promo',
                                theme: theme,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Use existing components
                      if (homeState.promotions?.isNotEmpty ?? false)
                        MenuCarousel(items: homeState.promotions!),

                      const UpcomingEvents(),

                      // Add some space at the bottom
                      SizedBox(height: mediaHeight(context, 0.1)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton({
    required IconData icon,
    required String label,
    required ShadThemeData theme,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.p,
        ),
      ],
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
