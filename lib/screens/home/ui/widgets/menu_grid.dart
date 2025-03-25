import 'dart:math' as math;
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:snapfood/screens/home/ui/widgets/menu_detail_dialog.dart';

// Renombrando la clase para reflejar que ahora es un carrusel
class MenuCarousel extends StatelessWidget {
  final List<MenuItem> items;
  final String? title;

  const MenuCarousel({
    required this.items,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        SizedBox(
          height: 220, // Altura fija para el carrusel
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 160, // Ancho fijo para cada tarjeta
                child: MenuItemCard(item: items[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Store the context at the build method level to ensure it has access to ScaffoldMessenger
    final parentContext = context;

    // Mover las declaraciones de variables fuera de la lista
    var showOfferTag = false;
    var isHotDeal = false;
    var isPromotionActive = false;

    if (item.promotions != null && item.promotions!.isNotEmpty) {
      final promotion = item.promotions!.first;
      isPromotionActive = (promotion.endTime == null ||
              DateTime.now().isBefore(promotion.endTime!)) &&
          DateTime.now().isAfter(promotion.startTime);

      if (isPromotionActive) {
        showOfferTag = true;
        isHotDeal = _isHotDeal(item, promotion);
      }
    }

    return GestureDetector(
      onTap: () => MenuDetailDialog.show(parentContext, item),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  item.photo ?? '',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: PhosphorIcon(
                      PhosphorIcons.image(),
                      color: Colors.green,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      onPressed: () {
                        // TODO: Implement favorite
                      },
                      icon: PhosphorIcon(
                        PhosphorIcons.heart(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (showOfferTag)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: isHotDeal
                        ? const FireEffectContainer()
                        : Container(
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Oferta',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                          ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (item.promotions != null &&
                          item.promotions!.isNotEmpty &&
                          isPromotionActive) ...[
                        Text(
                          '\$${item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '\$${_calculateDiscountedPrice(item).toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ] else
                        Text(
                          '\$${item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      const Spacer(),
                      Icon(
                        PhosphorIcons.star(),
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${item.trendingScore ?? 0}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
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

  // Calculate the discounted price based on promotion type
  double _calculateDiscountedPrice(MenuItem item) {
    if (item.promotions == null || item.promotions!.isEmpty) {
      return item.price.toDouble();
    }

    final promotion = item.promotions!.first;

    // Verificar si la promoción está activa
    final isPromotionActive = (promotion.endTime == null ||
            DateTime.now().isBefore(promotion.endTime!)) &&
        DateTime.now().isAfter(promotion.startTime);

    // Si la promoción no está activa, devolver el precio original
    if (!isPromotionActive) {
      return item.price.toDouble();
    }

    var discountedPrice = item.price.toDouble();

    if (promotion.type == 'AMOUNT') {
      discountedPrice = item.price.toDouble() - promotion.amount.toDouble();
    } else if (promotion.type == 'PERCENTAGE') {
      // Calculate percentage discount
      final discount =
          item.price.toDouble() * (promotion.amount.toDouble() / 100);
      discountedPrice = item.price.toDouble() - discount;
    }

    // Ensure price never goes below 0
    return discountedPrice > 0 ? discountedPrice : 0;
  }

  bool _isHotDeal(MenuItem item, Promotion promotion) {
    final originalPrice = item.price.toDouble();
    double discountPercentage = 0;

    if (promotion.type == 'PERCENTAGE') {
      // Para descuentos porcentuales, usamos directamente el porcentaje
      discountPercentage = promotion.amount.toDouble();
    } else if (promotion.type == 'AMOUNT') {
      // Para descuentos de monto fijo, calculamos qué porcentaje representa del precio original
      final discountAmount = promotion.amount.toDouble();
      discountPercentage = (discountAmount / originalPrice) * 100;
    }

    // Verificar si el descuento es mayor al 30%
    return discountPercentage >= 50;
  }
}

// Widget para el efecto de fuego
class FireEffectContainer extends StatefulWidget {
  const FireEffectContainer({
    super.key,
  });

  @override
  State<FireEffectContainer> createState() => _FireEffectContainerState();
}

class _FireEffectContainerState extends State<FireEffectContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<FireParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Crear algunas partículas de fuego
    for (var i = 0; i < 5; i++) {
      _particles.add(
        FireParticle(
          position: Offset(_random.nextDouble() * 40, 24),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 2,
            -_random.nextDouble() * 3 - 1,
          ),
          size: _random.nextDouble() * 3 + 1,
          lifetime: _random.nextDouble() * 0.7 + 0.3,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Actualizar partículas
        for (final particle in _particles) {
          particle.update();
          if (particle.isDead) {
            particle.reset(
              position: Offset(_random.nextDouble() * 40, 24),
              velocity: Offset(
                (_random.nextDouble() - 0.5) * 2,
                -_random.nextDouble() * 3 - 1,
              ),
              size: _random.nextDouble() * 3 + 1,
              lifetime: _random.nextDouble() * 0.7 + 0.3,
            );
          }
        }

        return Stack(
          children: [
            // Contenedor base con gradiente
            Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade900,
                    Colors.red,
                    Colors.orange,
                    Colors.amber,
                  ],
                  stops: [
                    0.0,
                    0.3 + 0.1 * math.sin(_controller.value * math.pi * 2),
                    0.6 + 0.1 * math.cos(_controller.value * math.pi * 2),
                    1.0,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Oferta HOT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Partículas de fuego (opcional, si se ven bien)
            if (_random.nextDouble() >
                0.7) // Solo mostrar partículas ocasionalmente
              ...(_particles.map(
                (particle) => Positioned(
                  left: particle.position.dx,
                  top: particle.position.dy,
                  child: Opacity(
                    opacity: particle.opacity,
                    child: Container(
                      width: particle.size,
                      height: particle.size,
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withValues(alpha: 0.5),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          ],
        );
      },
    );
  }
}

// Clase para representar una partícula de fuego
class FireParticle {
  Offset position;
  Offset velocity;
  double size;
  double lifetime;
  double age = 0;

  FireParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.lifetime,
  });

  void update() {
    position += velocity;
    age += 0.016; // Aproximadamente 60 FPS
  }

  void reset({
    required Offset position,
    required Offset velocity,
    required double size,
    required double lifetime,
  }) {
    this.position = position;
    this.velocity = velocity;
    this.size = size;
    this.lifetime = lifetime;
    age = 0;
  }

  bool get isDead => age >= lifetime;

  double get opacity => 1.0 - (age / lifetime);
}
