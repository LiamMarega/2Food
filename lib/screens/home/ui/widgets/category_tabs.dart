import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final selectedCategoryProvider = StateProvider<int>((ref) => 0);

class CategoryTabs extends ConsumerWidget {
  const CategoryTabs({super.key});

  static const List<String> categories = [
    'Specials',
    'Seasonal',
    'Appetizers',
    'Main courses',
    'Desserts',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: isSelected
                ? ShadButton(
                    onPressed: () {
                      ref.read(selectedCategoryProvider.notifier).state = index;
                    },
                    child: Text(categories[index]),
                  )
                : ShadButton.outline(
                    onPressed: () {
                      ref.read(selectedCategoryProvider.notifier).state = index;
                    },
                    child: Text(categories[index]),
                  ),
          );
        },
      ),
    );
  }
}
