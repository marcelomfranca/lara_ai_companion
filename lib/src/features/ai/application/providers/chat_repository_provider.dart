import 'package:lara_ai/src/features/ai/data/data_sources/delete_chat_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/application/providers/sqflite_provider.dart';
import '../../data/data_sources/exists_chat_data_source_impl.dart';
import '../../data/data_sources/get_chats_data_source_impl.dart';
import '../../data/data_sources/insert_chat_data_source_impl.dart';
import '../../data/data_sources/update_chat_data_source_impl.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/data/repositories/chat_repository.dart';

part 'chat_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  final db = ref.watch(sqfliteProvider).requireValue;

  return ChatRepositoryImpl(
    getChatsDataSource: GetChatsDataSourceImpl(db),
    insertChatDataSource: InsertChatDataSourceImpl(db),
    updateChatDataSource: UpdateChatDataSourceImpl(db),
    existsChatDataSource: ExistsChatDataSourceImpl(db),
    deleteChatDataSource: DeleteChatDataSourceImpl(db),
  );
}
