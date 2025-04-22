// QR Response model
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_data.freezed.dart';
part 'qr_data.g.dart';

@freezed
class QrResponse with _$QrResponse {
  factory QrResponse({
    required String order_hash,
    required String signature,
    required DateTime timestamp,
  }) = _QrResponse;

  factory QrResponse.fromJson(Map<String, dynamic> json) =>
      _$QrResponseFromJson(json);
}
