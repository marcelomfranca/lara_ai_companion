import 'dart:developer';

import 'package:lara_ai/src/features/ai/domain/data/data_sources/delete_chat_data_source.dart';
import 'package:sqflite/sqflite.dart';

final class DeleteChatDataSourceImpl implements DeleteChatDataSource {
  DeleteChatDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<void> delete(List<int> indexList, [bool? all = false]) async {
    log(':::indexList: $indexList');
    log(':::all: $all');

    if (all == true) {
      await _db.delete('chats');

      return;
    }

    final placeholders = List.filled(indexList.length, '?').join(',');

    await _db.delete(
      'chats',
      where: 'id IN ($placeholders)',
      whereArgs: indexList,
    );
  }
}
