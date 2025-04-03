import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapfood/common/models/order.dart';
import 'package:snapfood/screens/orders/widget/order_action_buttons.dart';
import 'package:snapfood/screens/orders/models/order_model.dart';
import 'package:snapfood/screens/orders/widget/order_detail_sheet.dart';
import 'package:snapfood/screens/orders/widget/reminder_toggle.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem order;

  const OrderItemCard({
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderData = order.orderData;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => OrderDetailSheet.show(context, order),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Product Image
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        order.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.receipt_long_rounded,
                              size: 40,
                              color: theme.primaryColor.withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderData != null
                              ? '${'ordersPage.orderInfo.orderNumber'.tr()}${orderData.id}'
                              : order.productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.store_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                orderData != null
                                    ? '${'ordersPage.orderInfo.fromRestaurant'.tr()} ${orderData.restaurant_id}'
                                    : order.storeName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (orderData != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${NumberFormat.currency(symbol: '\$').format(orderData.total_amount)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat('MMM dd, yyyy - HH:mm')
                                    .format(orderData.created_at),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Chevron icon
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Delivery method badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DeliveryMethodBadge(
                        deliveryMethod: order.deliveryMethod),
                  ),
                  if (orderData != null)
                    _getStatusBadge(orderData.status, theme),
                ],
              ),
            ),

            // Show reminder toggle if this is an active order with takeAway method
            if (order.deliveryMethod == DeliveryMethod.takeAway)
              ReminderToggle(orderId: order.id),

            // Show action buttons for active orders that are delivery type
            if (order.deliveryMethod == DeliveryMethod.delivery)
              OrderActionButtons(orderId: order.id),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _getStatusBadge(OrderStatus status, ThemeData theme) {
    Color backgroundColor;
    Color textColor;
    String translationKey;

    switch (status) {
      case OrderStatus.paid:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        translationKey = 'ordersPage.orderStatus.paid';
        break;
      case OrderStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        translationKey = 'ordersPage.orderStatus.pending';
        break;
      case OrderStatus.rejected:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        translationKey = 'ordersPage.orderStatus.rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        translationKey.tr(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class DeliveryMethodBadge extends StatelessWidget {
  final DeliveryMethod deliveryMethod;

  const DeliveryMethodBadge({
    required this.deliveryMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData badgeIcon;
    String translationKey;

    switch (deliveryMethod) {
      case DeliveryMethod.delivery:
        badgeColor = Colors.green[100]!;
        badgeIcon = Icons.delivery_dining;
        translationKey = 'ordersPage.deliveryMethod.delivery';
        break;
      case DeliveryMethod.pickUp:
        badgeColor = Colors.grey[100]!;
        badgeIcon = Icons.store;
        translationKey = 'ordersPage.deliveryMethod.pickUp';
        break;
      case DeliveryMethod.takeAway:
        badgeColor = Colors.blue[100]!;
        badgeIcon = Icons.takeout_dining;
        translationKey = 'ordersPage.deliveryMethod.takeAway';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badgeIcon,
            size: 16,
            color: Colors.black87,
          ),
          const SizedBox(width: 6),
          Text(
            translationKey.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
