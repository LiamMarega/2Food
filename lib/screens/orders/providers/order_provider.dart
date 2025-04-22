import 'dart:convert';
import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/common/models/order.dart' as order_model;
import 'package:snapfood/screens/orders/models/order_model.dart';
import 'package:snapfood/screens/orders/models/qr_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'order_provider.freezed.dart';
part 'order_provider.g.dart';

// Order state
@freezed
class OrderState with _$OrderState {
  factory OrderState({
    required Map<String, List<OrderItem>> orders,
    @Default(false) bool isLoading,
    String? error,
    QrResponse? qrData,
  }) = _OrderState;
}

// Order notifier
@Riverpod(keepAlive: true)
class Order extends _$Order {
  @override
  OrderState build() {
    // Initialize and fetch orders
    fetchOrders();
    return OrderState(orders: {});
  }

  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> fetchOrders() async {
    // state = state.copyWith(isLoading: true);

    try {
      final response = await supabase.from('orders').select();
      final data = response is List
          ? response
              .map(order_model.Order.fromJson)
              .toList()
          : <order_model.Order>[];

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

        switch (order.payment_status) {
          case order_model.OrderStatus.paid:
            categorizedOrders['Completed']!.add(orderItem);
          case order_model.OrderStatus.pending:
            categorizedOrders['Active']!.add(orderItem);
          case order_model.OrderStatus.rejected:
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
  Future<void> toggleReminder(String orderId, bool enabled) async {
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

  Future<QrResponse> getSecureQRData(String orderHash) async {
    final response = await supabase.functions
        .invoke('generate-qr', body: {'order_hash': orderHash});

    // Convert the response data to a String before decoding
    final responseData = response.data as String;

    final jsonData = jsonDecode(responseData) as Map<String, dynamic>;

    final qr = QrResponse.fromJson(jsonData);

    state = state.copyWith(qrData: qr);
    return qr;
  }
}
