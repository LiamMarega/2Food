import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/menu_type.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/common/utils/media_query.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';
import 'package:snapfood/screens/home/ui/providers/products_provider.dart';
import 'package:snapfood/screens/home/ui/widgets/carousels/carousel_restaurants.dart';
import 'package:snapfood/screens/home/ui/widgets/hand_animation.dart';
import 'package:snapfood/screens/home/ui/widgets/home_page_skeleton.dart';
import 'package:snapfood/screens/home/ui/widgets/menu_grid.dart';
import 'package:snapfood/screens/home/ui/widgets/upcoming_events.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();

  // Map of menu type names to their corresponding icons
  final Map<String, IconData> menuIcons = {
    'Pizza': LucideIcons.pizza,
    'Snacks': LucideIcons.cookie,
    'Hamburguesas': PhosphorIcons.hamburger_bold,
    'Promociones': LucideIcons.percent,
    'Bebidas': LucideIcons.beer,
    // Add more mappings as needed
  };

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final productsState = ref.watch(productsProvider);
    final theme = ShadTheme.of(context);

    // Show skeleton loading while data is loading
    if (homeState.isLoading ||
        homeState.promotions == null ||
        homeState.restaurants == null) {
      return const HomePageSkeleton();
    }

    final menuTypes = productsState.menuTypes ?? [];

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
                        Row(
                          children: [
                            Text(
                              'Hola, Liam ',
                              style: theme.textTheme.p.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const WavingHandEmoji(),
                          ],
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
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(LucideIcons.search, size: 16),
                ),
                suffix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                          borderRadius: kDefaultBorderRadius,
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
                                      '20% Off',
                                      style: theme.textTheme.h1.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '¡Oferta en tu primer experiencia!',
                                      style: theme.textTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '¡Disfruta de un fantástico 20% de descuento!',
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
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: kDefaultBorderRadius,
                                ),
                                child: MouseRegion(
                                  onEnter: (_) => setState(() {}),
                                  onExit: (_) => setState(() {}),
                                  child: GestureDetector(
                                    onTapDown: (_) => setState(() {}),
                                    onTapUp: (_) => setState(() {}),
                                    onTapCancel: () => setState(() {}),
                                    child: TweenAnimationBuilder(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      tween: Tween<double>(
                                        begin: 0.5,
                                        end: 1,
                                      ),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.venetianMask,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              size: 48,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Menu type categories from Supabase (horizontal scrolling)
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: menuTypes.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: menuTypes.length,
                                  itemBuilder: (context, index) {
                                    final menuType = menuTypes[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigate to products page with this menu type
                                          context.go(
                                            Uri(
                                              path: '/products',
                                              queryParameters: {
                                                'title': menuType.type,
                                                'type': menuType.id,
                                              },
                                            ).toString(),
                                          );
                                        },
                                        child: _buildCategoryButton(
                                          type: menuType,
                                          theme: theme,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),

                      const UpcomingEvents(),

                      SizedBox(height: mediaHeight(context, 0.02)),

                      // Use existing components
                      if (homeState.promotions?.isNotEmpty ?? false) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Super Ofertas',
                                style: theme.textTheme.h4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: TextButton(
                                  onPressed: () {
                                    // Find promo menu type ID if available
                                    final promoType = menuTypes
                                        .where((type) => type.type
                                            .toLowerCase()
                                            .contains('promoc'))
                                        .firstOrNull;

                                    context.go(
                                      Uri(
                                        path: '/products',
                                        queryParameters: {
                                          'title': 'Super Ofertas',
                                          'type': promoType?.id ?? 'Promo',
                                        },
                                      ).toString(),
                                    );
                                  },
                                  child: const Text('Ver más'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        MenuCarousel(items: [...homeState.promotions!]),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hamburguesas',
                                style: theme.textTheme.h4,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Find hamburger menu type ID
                                  final burgerType = menuTypes
                                      .where((type) => type.type
                                          .toLowerCase()
                                          .contains('hamburgues'))
                                      .firstOrNull;

                                  context.go(
                                    Uri(
                                      path: '/products',
                                      queryParameters: {
                                        'title': 'Hamburguesas',
                                        'type':
                                            burgerType?.id ?? 'Hamburguesas',
                                      },
                                    ).toString(),
                                  );
                                },
                                child: const Text('Ver más'),
                              ),
                            ],
                          ),
                        ),
                        MenuCarousel(
                          items: [...homeState.promotions!]..shuffle(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pizzas',
                                style: theme.textTheme.h4,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Find pizza menu type ID
                                  final pizzaType = menuTypes
                                      .where((type) => type.type
                                          .toLowerCase()
                                          .contains('pizza'))
                                      .firstOrNull;

                                  context.go(
                                    Uri(
                                      path: '/products',
                                      queryParameters: {
                                        'title': 'Pizzas',
                                        'type': pizzaType?.id ?? 'Pizza',
                                      },
                                    ).toString(),
                                  );
                                },
                                child: const Text('Ver más'),
                              ),
                            ],
                          ),
                        ),
                        MenuCarousel(
                          items: [...homeState.promotions!]..shuffle(),
                        ),
                      ],

                      // Add some space at the bottom
                      SizedBox(height: mediaHeight(context, 0.01)),

                      const CarouselRestaurants(),
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
    required MenuType type,
    required ShadThemeData theme,
  }) {
    // Map of menu type names to their corresponding icons
    final Map<String, IconData> typeToIcon = {
      'pizza': LucideIcons.pizza,
      'hamburguesa': PhosphorIcons.hamburger_bold,
      'snack': LucideIcons.cookie,
      'promocion': LucideIcons.percent,
      'cerveza': LucideIcons.beer,
      'bebida': LucideIcons.beer,
      'postre': LucideIcons.cake,
    };

    // Try to find an icon based on the type name
    IconData icon = LucideIcons.utensils; // Default icon
    final lowerType = type.type.toLowerCase();

    for (final entry in typeToIcon.entries) {
      if (lowerType.contains(entry.key)) {
        icon = entry.value;
        break;
      }
    }

    return Column(
      children: [
        Container(
          width: 60,
          height: 50,
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
        Text(
          type.type,
          style: theme.textTheme.p,
        ),
      ],
    );
  }
}
