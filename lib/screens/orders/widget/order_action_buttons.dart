import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/screens/orders/providers/order_provider.dart';

class OrderActionButtons extends ConsumerWidget {
  final String orderId;

  const OrderActionButtons({
    required this.orderId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Cancel Order Button
          Expanded(
            child: OutlinedButton(
              onPressed: () => _handleCancelOrder(context, ref),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[800],
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('ordersPage.actions.cancelOrder'.tr()),
            ),
          ),
          const SizedBox(width: 12),
          // Track Driver Button
          Expanded(
            child: ElevatedButton(
              onPressed: () => _handleTrackDriver(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('ordersPage.actions.trackDriver'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCancelOrder(BuildContext context, WidgetRef ref) {
    // Implementation for cancel order
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ordersPage.actions.cancelOrder'.tr()),
        content: Text('ordersPage.actions.confirmCancel'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ordersPage.actions.no'.tr()),
          ),
          TextButton(
            onPressed: () {
              // Cancel the order using provider
              ref.read(orderProvider.notifier).cancelOrder(orderId);
              Navigator.pop(context);
            },
            child: Text('ordersPage.actions.yes'.tr()),
          ),
        ],
      ),
    );
  }

  void _handleTrackDriver(BuildContext context) {
    // Implementation for track driver
    // In a real app, this would navigate to a driver tracking screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrackDriverPlaceholder(),
      ),
    );
  }
}

// Placeholder screen for tracking driver
class TrackDriverPlaceholder extends StatelessWidget {
  const TrackDriverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ordersPage.actions.trackDriverTitle'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'ordersPage.actions.trackDriverDescription'.tr(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text('ordersPage.actions.goBack'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
