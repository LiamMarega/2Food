import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/common/utils/media_query.dart';
import 'package:snapfood/screens/home/ui/providers/home_provider.dart';
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

  final categories = [
    (icon: LucideIcons.pizza, label: 'Pizza'),
    (icon: LucideIcons.cookie, label: 'Snacks'),
    (icon: PhosphorIcons.hamburger_bold, label: 'Burguers'),
    (icon: LucideIcons.percent, label: 'Promo'),
    (icon: LucideIcons.beer, label: 'Cerveza'),
  ];

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final theme = ShadTheme.of(context);

    // Show skeleton loading while data is loading
    if (homeState.isLoading ||
        homeState.promotions == null ||
        homeState.restaurants == null) {
      return const HomePageSkeleton();
    }

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

                      // Category buttons (horizontal scrolling)
                      SizedBox(
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: _buildCategoryButton(
                                  icon: categories[index].icon,
                                  label: categories[index].label,
                                  theme: theme,
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
                        MenuCarousel(items: [...homeState.promotions!]),
                        MenuCarousel(
                          items: [...homeState.promotions!]..shuffle(),
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
    required IconData icon,
    required String label,
    required ShadThemeData theme,
  }) {
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
          label,
          style: theme.textTheme.p,
        ),
      ],
    );
  }
}
