import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snapfood/common/models/order.dart';
import 'package:snapfood/common/utils/constants.dart';
import 'package:snapfood/screens/orders/models/order_model.dart';

class OrderDetailSheet extends StatelessWidget {
  const OrderDetailSheet({
    required this.orderItem,
    super.key,
  });

  final OrderItem orderItem;

  static void show(BuildContext context, OrderItem orderItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) {
          return OrderDetailSheet(orderItem: orderItem);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = orderItem.orderData;

    if (order == null) {
      return Center(
        child: Text(
          'ordersPage.detailSheet.noOrderData'.tr(),
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSheetHeader(context, theme),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildOrderHeader(context, theme, order),
                const SizedBox(height: 24),
                _buildOrderInfo(context, theme, order),
                const SizedBox(height: 24),
                _buildPaymentInfo(context, theme, order),
                const SizedBox(height: 40),
                _buildActions(context, theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Draggable handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'ordersPage.detailSheet.orderDetails'.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(BuildContext context, ThemeData theme, Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: kDefaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.orderNumber'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  '${order.id}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.orderDate'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  DateFormat('dd/MM/yyyy - HH:mm').format(order.created_at),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.orderStatus'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    statusText,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.orderTotal'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  NumberFormat.currency(symbol: r'$')
                      .format(order.total_amount),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context, ThemeData theme, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: kDefaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.restaurant'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                Flexible(
                  child: Text(
                    order.restaurant_id,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ordersPage.detailSheet.deliveryMethod'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                _buildDeliveryMethodBadge(context, order.order_type),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfo(BuildContext context, ThemeData theme, Order order) {
    final paymentInfo = order.mercadopago_info;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: kDefaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ordersPage.detailSheet.paymentInfo'.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (paymentInfo != null) ...[
              if (paymentInfo['payment_method'] != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ordersPage.detailSheet.paymentMethod'.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      paymentInfo['payment_method'].toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (paymentInfo['payment_id'] != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ordersPage.detailSheet.paymentId'.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      paymentInfo['payment_id'].toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ] else
              Text(
                'ordersPage.detailSheet.noPaymentInfo'.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: kDefaultBorderRadius,
          ),
        ),
        child: Text('ordersPage.detailSheet.close'.tr()),
      ),
    );
  }

  Widget _buildDeliveryMethodBadge(BuildContext context, String orderType) {
    Color badgeColor;
    IconData badgeIcon;
    String translationKey;

    switch (orderType.toLowerCase()) {
      case 'delivery':
        badgeColor = Colors.green[700]!;
        badgeIcon = Icons.delivery_dining;
        translationKey = 'ordersPage.deliveryMethod.delivery';
      case 'pickup':
        badgeColor = Colors.grey[700]!;
        badgeIcon = Icons.store;
        translationKey = 'ordersPage.deliveryMethod.pickUp';
      case 'takeaway':
        badgeColor = Colors.blue[700]!;
        badgeIcon = Icons.takeout_dining;
        translationKey = 'ordersPage.deliveryMethod.takeAway';
      default:
        badgeColor = Colors.grey[700]!;
        badgeIcon = Icons.local_shipping;
        translationKey = orderType;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badgeIcon,
            size: 16,
            color: badgeColor,
          ),
          const SizedBox(width: 6),
          Text(
            translationKey.tr(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.paid:
        return Colors.green[700]!;
      case OrderStatus.pending:
        return Colors.orange[700]!;
      case OrderStatus.rejected:
        return Colors.red[700]!;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.paid:
        return 'ordersPage.orderStatus.paid'.tr();
      case OrderStatus.pending:
        return 'ordersPage.orderStatus.pending'.tr();
      case OrderStatus.rejected:
        return 'ordersPage.orderStatus.rejected'.tr();
    }
  }
}
