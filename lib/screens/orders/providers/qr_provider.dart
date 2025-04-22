import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/screens/orders/models/qr_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'qr_provider.freezed.dart';
part 'qr_provider.g.dart';

// Qr state
@freezed
class QrState with _$QrState {
  factory QrState({
    @Default(false) bool loading,
    String? error,
    QrResponse? qrData,
  }) = _QrState;
}

// Qr notifier
@Riverpod(keepAlive: false)
class Qr extends _$Qr {
  @override
  QrState build(String orderHash) {
    // Initialize and fetch QR data
    log('adentro -1 $orderHash');

    getSecureQRData(orderHash);
    return QrState(loading: true);
  }

  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> getSecureQRData(String orderHash) async {
    // state = state.copyWith(loading: true);
    try {
      log('adentro $orderHash');
      final response = await supabase.functions
          .invoke('generate-qr', body: {'order_hash': orderHash});

      log('adentro 2 $orderHash');
      // Convert the response data to a String before decoding
      final responseData = response.data;

      log('adentro 3 $responseData');
      final qr = QrResponse.fromJson(responseData as Map<String, dynamic>);

      log('adentro 4 $qr');
      state = state.copyWith(qrData: qr, loading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }
}
