import 'package:flutter/foundation.dart';

enum OrderStatus {
  paid,
  pending,
  rejected,
}

class Order {
  final int id;
  final String user_id;
  final String restaurant_id;
  final double total_amount;
  final String order_type;
  final DateTime created_at;
  final OrderStatus status;
  final Map<String, dynamic>? mercadopago_info;

  Order({
    required this.id,
    required this.user_id,
    required this.restaurant_id,
    required this.total_amount,
    required this.order_type,
    required this.created_at,
    required this.status,
    this.mercadopago_info,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    OrderStatus mapStatus(String statusStr) {
      switch (statusStr) {
        case 'PAID':
          return OrderStatus.paid;
        case 'PENDING':
          return OrderStatus.pending;
        case 'REJECTED':
          return OrderStatus.rejected;
        default:
          return OrderStatus.pending;
      }
    }

    return Order(
      id: json['id'] as int,
      user_id: json['user_id'] as String,
      restaurant_id: json['restaurant_id'] as String,
      total_amount: (json['total_amount'] as num).toDouble(),
      order_type: json['order_type'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      status: mapStatus(json['status'] as String),
      mercadopago_info: json['mercadopago_info'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    String mapStatus(OrderStatus status) {
      switch (status) {
        case OrderStatus.paid:
          return 'PAID';
        case OrderStatus.pending:
          return 'PENDING';
        case OrderStatus.rejected:
          return 'REJECTED';
      }
    }

    return {
      'id': id,
      'user_id': user_id,
      'restaurant_id': restaurant_id,
      'total_amount': total_amount,
      'order_type': order_type,
      'created_at': created_at.toIso8601String(),
      'status': mapStatus(status),
      'mercadopago_info': mercadopago_info,
    };
  }

  static List<Order> converter(List<dynamic> raw) {
    return raw.map((e) => Order.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.user_id == user_id &&
        other.restaurant_id == restaurant_id &&
        other.total_amount == total_amount &&
        other.order_type == order_type &&
        other.created_at == created_at &&
        other.status == status &&
        mapEquals(other.mercadopago_info, mercadopago_info);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        restaurant_id.hashCode ^
        total_amount.hashCode ^
        order_type.hashCode ^
        created_at.hashCode ^
        status.hashCode ^
        mercadopago_info.hashCode;
  }
}
