import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/routes/routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the auth state for changes - this will trigger app rebuilds when auth changes
    final router = ref.watch(routerProvider);

    return EasyLocalization(
      supportedLocales: const [Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: Builder(
        builder: (context) => ShadApp.materialRouter(
          routerConfig: router,
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadSlateColorScheme.dark(),
          ),
          materialThemeBuilder: (context, theme) {
            return ThemeData(
              colorScheme: ColorScheme.light(
                primary: const Color(0xFF295F98),
                secondary: const Color(0xFFCDC2A5),
                tertiary: const Color(0xFFFFCF50),
                surface: theme.colorScheme.surface,
                onSurface: theme.colorScheme.onSurface,
              ),
            );
          },
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return ScaffoldMessenger(
              child: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
