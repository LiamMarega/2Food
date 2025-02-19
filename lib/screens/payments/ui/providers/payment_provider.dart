import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/common/models/mercadopago_preference.dart';

final paymentProvider = Provider((ref) => PaymentService());

class PaymentService {
  final _dio = Dio();

  Future<MercadoPagoPreference> createPreference({
    required String title,
    required int quantity,
    required double price,
  }) async {
    try {
      print('Creating preference');
      final response = await _dio.post(
        'http://192.168.0.108:3000/create_preferences',
        data: {
          'title': title,
          'quantity': quantity,
          'price': price,
          'currency_id': 'ARS',
        },
      );

      final preference = MercadoPagoPreference.fromJson(
        response.data as Map<String, dynamic>,
      );

      return preference;
    } catch (e) {
      throw Exception('Error creating preference: $e');
    }
  }
}
