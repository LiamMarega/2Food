import 'package:snapfood/common/models/order.dart';

enum DeliveryMethod {
  delivery,
  pickUp,
  takeAway,
}

class OrderItem {
  final String id;
  final String productName;
  final String storeName;
  final String imageUrl;
  final DeliveryMethod deliveryMethod;
  final bool reminderEnabled;
  final Order? orderData;

  OrderItem({
    required this.id,
    required this.productName,
    required this.storeName,
    required this.imageUrl,
    required this.deliveryMethod,
    this.reminderEnabled = false,
    this.orderData,
  });

  OrderItem copyWith({
    String? id,
    String? productName,
    String? storeName,
    String? imageUrl,
    DeliveryMethod? deliveryMethod,
    bool? reminderEnabled,
    Order? orderData,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      storeName: storeName ?? this.storeName,
      imageUrl: imageUrl ?? this.imageUrl,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      orderData: orderData ?? this.orderData,
    );
  }

  String get deliveryMethodText {
    switch (deliveryMethod) {
      case DeliveryMethod.delivery:
        return 'Delivery';
      case DeliveryMethod.pickUp:
        return 'Pick Up';
      case DeliveryMethod.takeAway:
        return 'Take Away';
    }
  }
}
