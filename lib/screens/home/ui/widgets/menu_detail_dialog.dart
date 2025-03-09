import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:snapfood/common/utils/media_query.dart';
import 'package:snapfood/screens/payments/ui/providers/payment_provider.dart';

class MenuDetailDialog extends ConsumerStatefulWidget {
  const MenuDetailDialog({
    required this.menuItem,
    required this.parentContext,
    super.key,
  });

  final MenuItem menuItem;
  final BuildContext parentContext;

  static Future<void> show(BuildContext context, MenuItem menuItem) {
    return showShadSheet(
      context: context,
      side: ShadSheetSide.bottom,
      animateIn: [
        const SlideEffect(
          begin: Offset(0, 1),
          end: Offset.zero,
        ),
        ShimmerEffect(duration: 1000.milliseconds),
      ],
      builder: (dialogContext) => MenuDetailDialog(
        menuItem: menuItem,
        parentContext: context,
      ),
    );
  }

  @override
  ConsumerState<MenuDetailDialog> createState() => _MenuDetailDialogState();
}

class _MenuDetailDialogState extends ConsumerState<MenuDetailDialog> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double get totalPrice => widget.menuItem.price.toDouble() * quantity;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = widget.menuItem.promotions != null &&
        widget.menuItem.promotions!.isNotEmpty;

    // Obtener la promoción si existe
    final promotion = hasDiscount ? widget.menuItem.promotions!.first : null;

    // Verificar si la promoción está activa (dentro del rango de fechas)
    final isPromotionActive = hasDiscount
        ? (promotion!.endTime == null ||
                DateTime.now().isBefore(promotion.endTime!)) &&
            DateTime.now().isAfter(promotion.startTime)
        : false;

    // Calcular el precio con descuento según el tipo de promoción
    var discountedPrice = widget.menuItem.price;
    var discountLabel = '';

    if (hasDiscount && isPromotionActive) {
      if (promotion.type == 'PERCENTAGE') {
        // Descuento porcentual
        final discountAmount = widget.menuItem.price * (promotion.amount / 100);
        discountedPrice = widget.menuItem.price - discountAmount;
        discountLabel = '-${promotion.amount.toInt()}%';
      } else if (promotion.type == 'AMOUNT') {
        // Descuento de monto fijo
        discountedPrice = widget.menuItem.price - promotion.amount;
        discountLabel = '-\$${promotion.amount.toInt()}';
      }

      // Asegurar que el precio no sea negativo
      if (discountedPrice < 0) {
        discountedPrice = 0;
      }
    }

    // Obtener la descripción de la promoción
    final promotionDescription = hasDiscount && promotion!.description != null
        ? promotion.description
        : '*No acumulable con otras promociones del local.';

    return ShadSheet(
      removeBorderRadiusWhenTiny: false,
      radius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      description: Stack(
        children: [
          // Contenido scrollable
          SizedBox(
            height: mediaHeight(context, 0.8),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 130,
              ), // Espacio para los botones fijos
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button and favorite/share icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.black),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Food image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(widget.menuItem.photo ?? ''),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  // Timer indicator (solo si hay promoción activa con fecha de fin)
                  if (isPromotionActive && promotion.endTime != null) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: Colors.amber.shade800),
                          const SizedBox(width: 8),
                          Text(
                            // Calcular tiempo restante hasta el fin de la promoción
                            _getRemainingTime(promotion.endTime!),
                            style: TextStyle(
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Title
                  Text(
                    widget.menuItem.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    widget.menuItem.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),

                  if (hasDiscount && isPromotionActive) ...[
                    const SizedBox(height: 16),
                    Text(
                      promotionDescription!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Price with discount
                  if (hasDiscount && isPromotionActive) ...[
                    Row(
                      children: [
                        Text(
                          '\$${widget.menuItem.price}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            discountLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Current price
                  Text(
                    '\$${isPromotionActive ? discountedPrice.toInt() : widget.menuItem.price}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),

                  const SizedBox(height: 16),

                  // Restaurant info
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'La Taberna',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Adolfo Alsina 431',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Time info (si hay promoción activa)
                  if (isPromotionActive) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.amber),
                          const SizedBox(width: 8),
                          Text(
                            'Promoción válida hasta ${_formatDate(promotion.endTime)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Promo options
                  Text(
                    'Promo solo para',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag_outlined),
                              const SizedBox(width: 8),
                              Text(
                                'Retirar',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.restaurant_outlined),
                              const SizedBox(width: 8),
                              Text(
                                'Comer en el local',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Botones fijos en la parte inferior
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Quantity selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: decrementQuantity,
                        ),
                        Text(
                          '$quantity',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: incrementQuantity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add button with price
                  Expanded(
                    child: ShadButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(paymentProvider).createPreference(
                              context: widget.parentContext,
                              title: widget.menuItem.name,
                              quantity: quantity,
                              price: (isPromotionActive
                                      ? discountedPrice
                                      : widget.menuItem.price)
                                  .toDouble(),
                              restaurantId: widget.menuItem.restaurantId,
                            );
                      },
                      child: Text(
                        'Añadir \$${(isPromotionActive ? discountedPrice : widget.menuItem.price).toInt() * quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para formatear la fecha
  String _formatDate(DateTime? date) {
    if (date == null) return 'No especificado';
    return '${date.day}/${date.month}/${date.year}';
  }

  // Método para calcular el tiempo restante
  String _getRemainingTime(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) return 'Finalizado';

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
