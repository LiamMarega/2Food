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
  final OrderStatus payment_status;
  final Map<String, dynamic>? mercadopago_info;
  final String order_hash;

  Order({
    required this.id,
    required this.user_id,
    required this.restaurant_id,
    required this.total_amount,
    required this.order_type,
    required this.created_at,
    required this.payment_status,
    required this.order_hash,
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
      payment_status: mapStatus(json['payment_status'] as String),
      mercadopago_info: json['mercadopago_info'] as Map<String, dynamic>?,
      order_hash: json['order_hash'] as String,
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
      'payment_status': mapStatus(payment_status),
      'mercadopago_info': mercadopago_info,
      'order_hash': order_hash,
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
        other.payment_status == payment_status &&
        mapEquals(other.mercadopago_info, mercadopago_info) &&
        other.order_hash == order_hash;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        order_hash.hashCode ^
        restaurant_id.hashCode ^
        total_amount.hashCode ^
        order_type.hashCode ^
        created_at.hashCode ^
        payment_status.hashCode ^
        mercadopago_info.hashCode;
  }
}
