import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/common/models/mercadopago_preference.dart';
import 'package:snapfood/common/widgets/global_alert.dart';
import 'package:snapfood/screens/payments/ui/page/payment_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MercadoPagoOAuthResponse {
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

class RestaurantToken {
  final int id;
  final String restaurantId;
  final String mpAccessToken;
  final String mpRefreshToken;

  RestaurantToken({
    required this.id,
    required this.restaurantId,
    required this.mpAccessToken,
    required this.mpRefreshToken,
  });

  factory RestaurantToken.fromJson(Map<String, dynamic> json) {
    return RestaurantToken(
      id: json['id'] as int,
      restaurantId: json['restaurant_id'] as String,
      mpAccessToken: json['mp_access_token'] as String,
      mpRefreshToken: json['mp_refresh_token'] as String,
    );
  }
}

final paymentProvider = Provider((ref) => PaymentService());

class PaymentService {
  final _dio = Dio();
  static const _baseUrl = 'http://192.168.0.108:3000';
  final SupabaseClient _client = Supabase.instance.client;

  Future<RestaurantToken?> getRestaurantToken(
      BuildContext context, String restaurantId) async {
    try {
      final data = await _client
          .from('restaurant_tokens')
          .select()
          .eq('restaurant_id', restaurantId)
          .maybeSingle();

      if (data == null) {
        return null;
      }

      return RestaurantToken.fromJson(data);
    } catch (e) {
      GlobalAlert.showError(context, 'Error fetching restaurant token: $e');
      return null;
    }
  }

  Future<bool> insertRestaurantToken({
    required BuildContext context,
    required String restaurantId,
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _client.from('restaurant_tokens').insert({
        'restaurant_id': restaurantId,
        'mp_access_token': accessToken,
        'mp_refresh_token': refreshToken,
      });

      GlobalAlert.showSuccess(context, 'Token inserted successfully');
      return true;
    } catch (e) {
      GlobalAlert.showError(context, 'Error inserting restaurant token: $e');
      return false;
    }
  }

  Future<bool> updateRestaurantToken({
    required BuildContext context,
    required int tokenId,
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _client.from('restaurant_tokens').update({
        'mp_access_token': accessToken,
        'mp_refresh_token': refreshToken,
      }).eq('id', tokenId);

      GlobalAlert.showSuccess(context, 'Token updated successfully');
      return true;
    } catch (e) {
      GlobalAlert.showError(context, 'Error updating restaurant token: $e');
      return false;
    }
  }

  Future<MercadoPagoOAuthResponse?> getOAuthToken({
    required BuildContext context,
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
      GlobalAlert.showError(context, 'Error obtaining OAuth token: $e');
      return null;
    }
  }

  Future<MercadoPagoPreference?> createPreference({
    required BuildContext context,
    required String title,
    required int quantity,
    required double price,
    required String restaurantId,
  }) async {
    try {
      log('Creating payment preference for restaurant: $restaurantId');
      final token = await getRestaurantToken(context, restaurantId);
      if (token == null) {
        GlobalAlert.showError(
            context, 'No token found for restaurant: $restaurantId');
        return null;
      }

      log('Restaurant token found, creating preference with MercadoPago');
      final response = await _dio.post(
        '$_baseUrl/create_preferences',
        data: {
          'title': title,
          'quantity': quantity,
          'price': price,
          'unit_price': price,
          'currency_id': 'ARS',
          'marketplace_id': token.mpAccessToken,
        },
      );

      final preference = MercadoPagoPreference.fromJson(
        response.data as Map<String, dynamic>,
      );

      log('Preference created successfully: ${preference.id}');
      log('Navigating to payment screen with URL: ${preference.initPoint}');

      // Navigate to payment screen with the URL as extra parameter
      if (context.mounted) {
        // Use named route navigation with the correct name
        context.goNamed('payment', extra: preference.sandboxInitPoint);
      }

      return preference;
    } catch (e) {
      log("Error creating payment preference: $e");
      if (context.mounted) {
        GlobalAlert.showError(context, 'Error creating payment preference: $e');
      }
      return null;
    }
  }
}
