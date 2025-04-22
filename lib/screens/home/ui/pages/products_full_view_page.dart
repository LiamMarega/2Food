import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:snapfood/common/models/menu_type.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/screens/home/ui/providers/products_provider.dart';
import 'package:snapfood/screens/home/ui/widgets/home_page_skeleton.dart';

class ProductsFullViewPage extends ConsumerStatefulWidget {
  final String? categoryTitle;
  final String? categoryType;

  const ProductsFullViewPage({
    this.categoryTitle = 'Productos',
    this.categoryType,
    super.key,
  });

  @override
  ConsumerState<ProductsFullViewPage> createState() =>
      _ProductsFullViewPageState();
}

class _ProductsFullViewPageState extends ConsumerState<ProductsFullViewPage> {
  String? _selectedFilterId;

  @override
  void initState() {
    super.initState();
    _selectedFilterId = widget.categoryType;

    // Initialize the products fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryType != null) {
        ref
            .read(productsProvider.notifier)
            .fetchProductsByMenuType(widget.categoryType);
      } else {
        ref.read(productsProvider.notifier).fetchAllProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final theme = ShadTheme.of(context);

    // Show skeleton loading while data is loading
    if (productsState.isLoading) {
      return const Scaffold(
        body: HomePageSkeleton(),
      );
    }

    // Get products from the provider
    final products = productsState.products ?? [];
    final menuTypes = productsState.menuTypes ?? [];

    // Get the current menu type name for display
    var categoryTitle = widget.categoryTitle ?? 'Productos';
    if (_selectedFilterId != null) {
      final selectedMenuType =
          menuTypes.where((type) => type.id == _selectedFilterId).firstOrNull;
      if (selectedMenuType != null) {
        categoryTitle = selectedMenuType.type;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter chips
          _buildFilterChips(theme, menuTypes),

          // Title row with "Ver todos" button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryTitle,
                  style: theme.textTheme.h4,
                ),
                TextButton(
                  onPressed: () {
                    // Reset filter to show all products
                    setState(() {
                      _selectedFilterId = null;
                    });
                    ref.read(productsProvider.notifier).fetchAllProducts();
                  },
                  child: const Text('Ver todos'),
                ),
              ],
            ),
          ),

          // Products grid view
          Expanded(
            child: products.isEmpty
                ? _buildEmptyProductsMessage()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(products[index], theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(ShadThemeData theme, List<MenuType> menuTypes) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuTypes.length,
        itemBuilder: (context, index) {
          final menuType = menuTypes[index];
          final isSelected = _selectedFilterId == menuType.id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(menuType.type),
              onSelected: (selected) {
                setState(() {
                  _selectedFilterId = selected ? menuType.id : null;
                });

                if (selected) {
                  ref
                      .read(productsProvider.notifier)
                      .fetchProductsByMenuType(menuType.id);
                } else {
                  ref.read(productsProvider.notifier).fetchAllProducts();
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: theme.colorScheme.primary.withOpacity(0.2),
              checkmarkColor: theme.colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(MenuItem item, ShadThemeData theme) {
    // Logic to determine if there's an active promotion
    var showOfferTag = false;
    var discountedPrice = item.price.toDouble();

    if (item.promotions != null && item.promotions!.isNotEmpty) {
      final promotion = item.promotions!.first;
      final isPromotionActive = (promotion.endTime == null ||
              DateTime.now().isBefore(promotion.endTime!)) &&
          DateTime.now().isAfter(promotion.startTime);

      if (isPromotionActive) {
        showOfferTag = true;
        if (promotion.type == 'AMOUNT') {
          discountedPrice = item.price.toDouble() - promotion.amount.toDouble();
        } else if (promotion.type == 'PERCENTAGE') {
          discountedPrice =
              item.price.toDouble() * (1 - promotion.amount.toDouble() / 100);
        }
      }
    }

    return GestureDetector(
      onTap: () {
        // Handle product selection
        // TODO: Show detail view or add to cart
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: kDefaultBorderRadius,
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with offer tag
            Stack(
              children: [
                Image.network(
                  item.photo ?? '',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(PhosphorIcons.image_bold),
                    );
                  },
                ),
                if (showOfferTag)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Oferta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description != null)
                    Text(
                      item.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (showOfferTag) ...[
                        Text(
                          '\$${item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        '\$${showOfferTag ? discountedPrice.toStringAsFixed(0) : item.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      if (item.trendingScore != null)
                        Row(
                          children: [
                            const Icon(
                              PhosphorIcons.star_bold,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${item.trendingScore}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyProductsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.shopping_bag_bold,
            size: 48,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay productos disponibles',
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
