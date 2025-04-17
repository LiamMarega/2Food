import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfood/common/app.dart';
import 'package:snapfood/common/services/core/config/supabase_config.dart';
import 'package:snapfood/common/services/firebase/firebase_options.dart';
import 'package:snapfood/common/utils/bootstrap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inicializa Supabase con tus credenciales
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _getDeviceToken();

  await bootstrap(
    () => EasyLocalization(
      supportedLocales: const [Locale('es'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

Future<void> _getDeviceToken() async {
  try {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      print('Device Token: $fcmToken');
    }
  } catch (e) {
    print('Error getting device token: $e');
  }
}
