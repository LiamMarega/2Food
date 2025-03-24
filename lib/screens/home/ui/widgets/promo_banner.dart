import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PromoItem {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const PromoItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,
  });
}

class PromoBanner extends StatefulWidget {
  final List<PromoItem> promos;

  static const List<PromoItem> _defaultPromos = [
    PromoItem(
      imageUrl:
          'https://parana.gob.ar/writable/uploads/6559edad5f83b74d9fdf7d0bfbf73afa.jpg',
      title: 'Celebrate Love at\nGourmetGrove',
      description:
          "Treat your special someone to our exclusive Valentine's menu.",
    ),
    PromoItem(
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      title: 'Fresh & Local\nIngredients',
      description:
          'Discover our farm-to-table experience with the finest local produce.',
    ),
    PromoItem(
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      title: 'Special Events\n& Catering',
      description:
          'Make your events memorable with our professional catering services.',
    ),
  ];

  const PromoBanner({
    super.key,
    this.promos = _defaultPromos,
  });

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        if (_currentPage < widget.promos.length - 1) {
          _currentPage++;
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _currentPage = 0;
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.promos.length,
              itemBuilder: (context, index) {
                final promo = widget.promos[index];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        promo.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.7),
                                Colors.black.withValues(alpha: 0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.promos.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
