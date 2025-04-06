import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/common/models/order.dart';
import 'package:snapfood/screens/orders/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Order state
class OrderState {
  final Map<String, List<OrderItem>> orders;
  final bool isLoading;
  final String? error;

  OrderState({
    required this.orders,
    this.isLoading = false,
    this.error,
  });

  OrderState copyWith({
    Map<String, List<OrderItem>>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Order notifier
class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState(orders: {}));

  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true);

    try {
      final data = await supabase
          .from('orders')
          .select()
          .withConverter(Order.converter);

      final categorizedOrders = <String, List<OrderItem>>{
        'Active': [],
        'Completed': [],
        'Canceled': [],
      };

      // Convert and categorize orders
      for (final order in data) {
        final orderItem = OrderItem(
          id: order.id.toString(),
          productName: 'Order #${order.id}',
          storeName: 'Restaurant ID: ${order.restaurant_id}',
          imageUrl: 'https://placehold.co/64x64',
          deliveryMethod: _getDeliveryMethod(order.order_type),
          orderData: order,
        );

        switch (order.status) {
          case OrderStatus.paid:
            categorizedOrders['Completed']!.add(orderItem);
          case OrderStatus.pending:
            categorizedOrders['Active']!.add(orderItem);
          case OrderStatus.rejected:
            categorizedOrders['Canceled']!.add(orderItem);
        }
      }

      state = state.copyWith(
        orders: categorizedOrders,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      log('Error fetching orders: $e');
      log(stackTrace.toString());
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load orders: $e',
      );
    }
  }

  DeliveryMethod _getDeliveryMethod(String orderType) {
    switch (orderType.toLowerCase()) {
      case 'delivery':
        return DeliveryMethod.delivery;
      case 'pickup':
        return DeliveryMethod.pickUp;
      case 'takeaway':
        return DeliveryMethod.takeAway;
      default:
        return DeliveryMethod.delivery;
    }
  }

  // Toggle order reminder
  void toggleReminder(String orderId, bool enabled) {
    final orders = state.orders;

    for (final category in orders.keys) {
      final categoryOrders = orders[category]!;
      final orderIndex =
          categoryOrders.indexWhere((order) => order.id == orderId);

      if (orderIndex != -1) {
        final order = categoryOrders[orderIndex];
        final updatedOrder = order.copyWith(reminderEnabled: enabled);

        final updatedOrders = [...categoryOrders];
        updatedOrders[orderIndex] = updatedOrder;

        final updatedCategoryOrders = Map<String, List<OrderItem>>.from(orders);
        updatedCategoryOrders[category] = updatedOrders;

        state = state.copyWith(orders: updatedCategoryOrders);
        break;
      }
    }
  }

  // Cancel an order
  void cancelOrder(String orderId) {
    // In a real app, you would make an API call to update the order status
    try {
      supabase
          .from('orders')
          .update({'status': 'REJECTED'})
          .eq('id', int.parse(orderId))
          .then((_) {
            fetchOrders(); // Refresh orders after update
          });
    } catch (e) {
      log('Error cancelling order: $e');
      state = state.copyWith(
        error: 'Failed to cancel order: $e',
      );
    }
  }
}

// Provider
final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final notifier = OrderNotifier();
  // Fetch orders immediately
  notifier.fetchOrders();
  return notifier;
});
