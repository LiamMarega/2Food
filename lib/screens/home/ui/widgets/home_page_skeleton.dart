import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snapfood/common/utils/media_query.dart';

class HomePageSkeleton extends StatelessWidget {
  const HomePageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
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
                            const CustomShimmer(
                              height: 24,
                              width: 100,
                              borderRadius: 8,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          PhosphorIcons.bell_bold,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.error.withValues(alpha: 0.7),
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
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(
                      PhosphorIcons.magnifying_glass_bold,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CustomShimmer(
                        height: 20,
                        width: double.infinity,
                        borderRadius: 4,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      PhosphorIcons.x_bold,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promotion Banner (Limited Time Offer)
                      Container(
                        margin: const EdgeInsets.all(16),
                        height: 160,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            // Left side content (text)
                            const Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomShimmer(
                                      height: 28,
                                      width: 100,
                                      borderRadius: 8,
                                    ),
                                    SizedBox(height: 8),
                                    CustomShimmer(
                                      height: 20,
                                      width: 150,
                                      borderRadius: 8,
                                    ),
                                    SizedBox(height: 16),
                                    CustomShimmer(
                                      height: 14,
                                      width: 180,
                                      borderRadius: 4,
                                    ),
                                    SizedBox(height: 8),
                                    CustomShimmer(
                                      height: 14,
                                      width: 120,
                                      borderRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right side content (image)
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: CustomShimmer(
                                    height: 48,
                                    width: 48,
                                    borderRadius: 24,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              5,
                              (index) => _buildCategoryButtonSkeleton(),
                            ),
                          ),
                        ),
                      ),

                      // Food Items Section Title
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomShimmer(
                              height: 24,
                              width: 120,
                              borderRadius: 6,
                            ),
                            CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: 6,
                            ),
                          ],
                        ),
                      ),

                      // Food Items Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return _buildFoodCardSkeleton();
                          },
                        ),
                      ),

                      SizedBox(height: mediaHeight(context, 0.02)),

                      // Upcoming Events Section
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomShimmer(
                              height: 24,
                              width: 180,
                              borderRadius: 6,
                            ),
                            CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: 6,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Events Horizontal List
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 280,
                              margin: const EdgeInsets.only(right: 16),
                              child: const CustomShimmer(
                                height: 150,
                                width: 280,
                                borderRadius: 16,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Restaurants Section Title
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomShimmer(
                              height: 24,
                              width: 140,
                              borderRadius: 6,
                            ),
                            CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: 6,
                            ),
                          ],
                        ),
                      ),

                      // Restaurants Horizontal List
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.only(right: 16),
                              child: const CustomShimmer(
                                height: 200,
                                width: 300,
                                borderRadius: 16,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),
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

  Widget _buildCategoryButtonSkeleton() {
    return const Column(
      children: [
        CustomShimmer(
          height: 60,
          width: 60,
          borderRadius: 30,
        ),
        SizedBox(height: 8),
        CustomShimmer(
          height: 16,
          width: 60,
          borderRadius: 4,
        ),
      ],
    );
  }

  Widget _buildFoodCardSkeleton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmer(
            height: 120,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                CustomShimmer(
                  height: 18,
                  width: 120,
                  borderRadius: 4,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomShimmer(
                      height: 18,
                      width: 80,
                      borderRadius: 4,
                    ),
                    CustomShimmer(
                      height: 24,
                      width: 24,
                      borderRadius: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A customizable shimmer widget that can be used for skeleton loading effects
class CustomShimmer extends StatelessWidget {
  /// Creates a new [CustomShimmer] widget
  const CustomShimmer({
    required this.height, required this.width, super.key,
    this.borderRadius = 0,
    this.baseColor,
    this.highlightColor,
  });

  /// The height of the shimmer effect
  final double height;

  /// The width of the shimmer effect
  final double width;

  /// The border radius of the shimmer effect
  final double borderRadius;

  /// The base color of the shimmer effect
  final Color? baseColor;

  /// The highlight color of the shimmer effect
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade400.withValues(alpha: 0.8),
      highlightColor: highlightColor ?? Colors.grey.shade300,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
