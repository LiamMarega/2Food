import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/generated_classes.dart';

class MenuDetailDialog extends StatelessWidget {
  const MenuDetailDialog({
    required this.menuItem,
    super.key,
  });

  final MenuItems menuItem;

  static Future<void> show(BuildContext context, MenuItems menuItem) {
    return showShadDialog(
      context: context,
      animateIn: [ShimmerEffect(duration: 1000.milliseconds)],
      builder: (context) => MenuDetailDialog(menuItem: menuItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      radius: BorderRadius.circular(20),
      removeBorderRadiusWhenTiny: false,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      title: Text(
        menuItem.name,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(menuItem.photo ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            menuItem.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$${menuItem.price}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      // if (menuItem.discountPrice != null) ...[
                      //   const SizedBox(width: 8),
                      //   Text(
                      //     '\$${menuItem.discountPrice}',
                      //     style:
                      //         Theme.of(context).textTheme.titleSmall?.copyWith(
                      //               decoration: TextDecoration.lineThrough,
                      //               color: Colors.grey,
                      //             ),
                      //   ),
                      // ],
                    ],
                  ),
                ],
              ),
              ShadButton.outline(
                onPressed: () {
                  // Add to cart logic here
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_shopping_cart),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
