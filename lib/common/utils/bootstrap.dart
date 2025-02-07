import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final container = ProviderContainer(
    observers: [
      _ProviderLogger(),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: await builder(),
    ),
  );
}

/// A class that logs all provider changes
class _ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}''');
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log('''
{
  provider: ${provider.name ?? provider.runtimeType},
  value: $value
}''');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log(
      'Provider error: ${provider.name ?? provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
