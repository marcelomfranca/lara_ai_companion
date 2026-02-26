import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'hardcoded_string_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

extension AsyncValueSmartLoading<T> on AsyncValue<T> {
  AsyncValue<T> withSmartLoading({String? msg}) {
    SmartDialog.showLoading(msg: msg ?? 'Loading...'.hardcoded);

    return const AsyncLoading();
  }
}

extension AsyncValueDismissLoading on AsyncValue {
  void dismissLoadingOnResult() {
    if (!isLoading) {
      SmartDialog.dismiss();
    }
  }
}
