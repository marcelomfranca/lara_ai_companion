import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {
  const RiverpodObserver();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    log('Provider ${context.provider} was initialized with $value');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    log('Provider ${context.provider} was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    log(
      'Provider ${context.provider} updated from $previousValue to $newValue',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    log('Provider ${context.provider} threw $error at $stackTrace');
  }
}
