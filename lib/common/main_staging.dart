import 'package:flutter/widgets.dart';
import 'package:snapfood/common/app.dart';
import 'package:snapfood/common/utils/bootstrap.dart';
import 'package:snapfood/core/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Supabase con tus credenciales
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  await bootstrap(() => const App());
}
