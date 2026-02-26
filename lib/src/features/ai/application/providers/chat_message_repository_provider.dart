import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/application/providers/sqflite_provider.dart';
import '../../data/data_sources/get_messages_data_source_impl.dart';
import '../../data/data_sources/save_message_data_source_impl.dart';
import '../../data/repositories/chat_message_repository_impl.dart';
import '../../domain/data/repositories/chat_message_repository.dart';

part 'chat_message_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ChatMessageRepository chatMessageRepository(Ref ref) {
  final db = ref.watch(sqfliteProvider).requireValue;

  return ChatMessageRepositoryImpl(
    getMessagesDataSource: GetMessagesDataSourceImpl(db),
    saveMessageDataSource: SaveMessageDataSourceImpl(db),
  );
}
