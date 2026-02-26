import 'dart:io';

final class NetworkLookup {
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on Exception catch (_) {
      return false;
    }
  }

  Stream<bool> watchConnection() async* {
    yield await isConnected;
    yield* Stream.periodic(
      const Duration(seconds: 5),
    ).asyncMap((_) => isConnected);
  }
}
