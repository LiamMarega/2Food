import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/screens/orders/providers/order_provider.dart';

class ReminderToggle extends ConsumerStatefulWidget {
  final String orderId;

  const ReminderToggle({
    required this.orderId,
    super.key,
  });

  @override
  ConsumerState<ReminderToggle> createState() => _ReminderToggleState();
}

class _ReminderToggleState extends ConsumerState<ReminderToggle> {
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReminderState();
    });
  }

  void _loadReminderState() {
    final orderState = ref.read(orderProvider);

    for (final category in orderState.orders.keys) {
      final categoryOrders = orderState.orders[category]!;
      for (final order in categoryOrders) {
        if (order.id == widget.orderId) {
          setState(() {
            _isEnabled = order.reminderEnabled;
          });
          break;
        }
      }
    }
  }

  void _toggleReminder(bool value) {
    setState(() {
      _isEnabled = value;
    });
    ref.read(orderProvider.notifier).toggleReminder(widget.orderId, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ordersPage.actions.reminder'.tr(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Switch(
            value: _isEnabled,
            onChanged: _toggleReminder,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
