import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/common/models/mercadopago_preference.dart';

class   MercadoPagoOAuthResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;
  final String userId;
  final int? refreshExpires;
  final String? refreshToken;
  final String? liveMode;

  MercadoPagoOAuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
    required this.userId,
    this.refreshExpires,
    this.refreshToken,
    this.liveMode,
  });

  factory MercadoPagoOAuthResponse.fromJson(Map<String, dynamic> json) {
    return MercadoPagoOAuthResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      scope: json['scope'] as String,
      userId: json['user_id'] as String,
      refreshExpires: json['refresh_expires'] as int?,
      refreshToken: json['refresh_token'] as String?,
      liveMode: json['live_mode'] as String?,
    );
  }
}

final paymentProvider = Provider((ref) => PaymentService());

class PaymentService {
  final _dio = Dio();
  static const _baseUrl = 'http://192.168.0.108:3000';

  Future<MercadoPagoOAuthResponse> getOAuthToken({
    required String clientId,
    required String clientSecret,
    required String code,
    required String redirectUri,
  }) async {
    try {
      final response = await _dio.post(
        'https://auth.mercadopago.com.ar/oauth/token',
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'grant_type': 'authorization_code',
          'redirect_uri': redirectUri,
        },
      );

      return MercadoPagoOAuthResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Error obtaining OAuth token: $e');
    }
  }

  Future<MercadoPagoPreference> createPreference({
    required String title,
    required int quantity,
    required double price,
  }) async {
    try {
      print('Creating preference');
      final response = await _dio.post(
        '$_baseUrl/create_preferences',
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
