import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/common/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return EasyLocalization(
      supportedLocales: const [Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: Builder(
        builder: (context) => ShadApp.cupertinoRouter(
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadOrangeColorScheme.light(),
          ),
          cupertinoThemeBuilder: (context, theme) {
            return theme.copyWith(applyThemeToAll: true);
          },
          materialThemeBuilder: (context, theme) {
            return theme.copyWith(
              appBarTheme: const AppBarTheme(toolbarHeight: 52),
            );
          },
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: router,
        ),
      ),
    );
  }
}
