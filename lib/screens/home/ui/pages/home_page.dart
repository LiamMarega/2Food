import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  final double _searchBarHeight =
      80; // Altura aproximada de la barra de búsqueda

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    const parallaxFactor = 0.5;
    final searchBarOffset = -min(_scrollOffset, _searchBarHeight);

    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Usando un color gris oscuro en lugar de negro
      body: SafeArea(
        child: Stack(
          children: [
            // Contenido desplazable con efecto parallax
            CustomScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                // Espacio para permitir que el contenido comience debajo de la barra de búsqueda
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: _searchBarHeight + 20,
                  ), // Altura de la barra + espacio adicional
                ),
                // Contenedor principal con todo el contenido
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: Offset(0, _scrollOffset * parallaxFactor),
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
                          // Promo Banner
                          const PromoBanner(),
                          const SizedBox(height: 16),

                          // Category Tabs
                          ColoredBox(
                            color: Theme.of(context).colorScheme.surface,
                            child: const CategoryTabs(),
                          ),

                          // Menu Carousel (no scrollable verticalmente)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child:
                                MenuCarousel(items: homeState.promotions ?? []),
                          ),

                          // Upcoming Events
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: UpcomingEvents(),
                          ),

                          // Espacio adicional al final para asegurar que todo sea visible
                          SizedBox(height: mediaHeight(context, 0.2)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Barra de búsqueda que se oculta al hacer scroll
            Positioned(
              top: searchBarOffset, // Se mueve hacia arriba con el scroll
              left: 0,
              right: 0,
              child: Container(
                color: Colors.grey[900],
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const <String>[];
                    }
                    // Lista combinada de comidas y restaurantes en español
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
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: 'Search for food or restaurants...',
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
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
          ],
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
