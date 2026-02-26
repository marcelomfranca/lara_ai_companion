import '../../utils/misc/network_lookup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connection_provider.g.dart';

@riverpod
Stream<bool> internetConnection(Ref ref) {
  final network = NetworkLookup();

  return network.watchConnection();
}
