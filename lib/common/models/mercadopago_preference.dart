import 'package:freezed_annotation/freezed_annotation.dart';

part 'mercadopago_preference.freezed.dart';
part 'mercadopago_preference.g.dart';

@freezed
class MercadoPagoPreference with _$MercadoPagoPreference {
  factory MercadoPagoPreference({
    required String id,
    required String initPoint,
    required String sandboxInitPoint,
  }) = _MercadoPagoPreference;

  factory MercadoPagoPreference.fromJson(Map<String, dynamic> json) =>
      _$MercadoPagoPreferenceFromJson(json);
}
