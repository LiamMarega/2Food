import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:snapfood/screens/home/ui/providers/restaurant_detail_provider.dart';
import 'package:snapfood/screens/home/ui/widgets/menu_detail_dialog.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({
    required this.restaurant,
    super.key,
  });

  final Restaurants restaurant;

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 100);
  double _rating = 3;
  final List<String> _selectedIngredients = [];

  final List<String> _availableIngredients = [
    'Vegetarian',
    'Vegan',
    'Gluten Free',
    'Dairy Free',
    'Spicy',
    'Nuts',
    'Seafood',
    'Halal',
  ];

  @override
  void initState() {
    super.initState();
    // Fetch menu items after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMenuItems();
    });
  }

  void _fetchMenuItems() {
    final container = ProviderScope.containerOf(context);
    container
        .read(
          restaurantDetailProvider(restaurantId: widget.restaurant.id).notifier,
        )
        .fetchMenuItems(widget.restaurant.id);
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Price Range',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            RangeSlider(
              values: _priceRange,
              max: 100,
              divisions: 20,
              labels: RangeLabels(
                '\$${_priceRange.start.round()}',
                '\$${_priceRange.end.round()}',
              ),
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Minimum Rating',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _rating,
              max: 5,
              divisions: 10,
              label: _rating.toString(),
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Dietary Preferences',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableIngredients.map((ingredient) {
                final isSelected = _selectedIngredients.contains(ingredient);
                return FilterChip(
                  selected: isSelected,
                  label: Text(ingredient),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedIngredients.add(ingredient);
                      } else {
                        _selectedIngredients.remove(ingredient);
                      }
                    });
                  },
                  backgroundColor: isSelected
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1)
                      : null,
                  checkmarkColor: Theme.of(context).colorScheme.primary,
                  selectedColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.2),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Apply filters
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'restaurant-${widget.restaurant.id}',
                    child: Image.network(
                      widget.restaurant.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Container(
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
                    ),
                  ),
                  // Restaurant info
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.restaurant.name,
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
                          widget.restaurant.description ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.95),
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ShadInput(
                      controller: _searchController,
                      placeholder: const Text('Search dishes...'),
                      prefix: const Icon(Icons.search),
                      onChanged: (value) {
                        //
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ShadButton.outline(
                    icon: const Icon(Icons.tune),
                    onPressed: _showFilterBottomSheet,
                  ),
                ],
              ),
            ),
          ),
          // Products Grid
          Consumer(
            builder: (context, ref, child) {
              final restaurantState = ref.watch(
                restaurantDetailProvider(restaurantId: widget.restaurant.id),
              );

              return restaurantState.when(
                loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Center(child: Text('Error: $error')),
                ),
                data: (state) {
                  final menuItems = state.menuItems;

                  if (menuItems == null || menuItems.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(child: Text('No menu items available')),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.65,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final menuItem = menuItems[index];
                          return ProductCard(
                            product: menuItem,
                          );
                        },
                        childCount: menuItems.length,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });

  final MenuItem product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MenuDetailDialog.show(context, product),
      child: FoodCard(product: product),
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    required this.product,
    super.key,
  });

  final MenuItem product; // Keep it as MenuItem type

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(product.photo ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.5),
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                ShadButton.outline(
                  onPressed: () {},
                  child: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Sample products data
