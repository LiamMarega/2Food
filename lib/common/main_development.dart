import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/common/app.dart';
import 'package:snapfood/common/utils/bootstrap.dart';
import 'package:snapfood/core/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inicializa Supabase con tus credenciales
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  await bootstrap(
    () => EasyLocalization(
      supportedLocales: const [Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}
