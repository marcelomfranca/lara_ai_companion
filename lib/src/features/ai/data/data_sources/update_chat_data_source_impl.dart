import 'package:sqflite/sqflite.dart';

import '../../domain/data/data_sources/update_chat_data_source.dart';

final class UpdateChatDataSourceImpl implements UpdateChatDataSource {
  UpdateChatDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<int> update(String uid, {required Map<String, Object?> map}) async {
    final updated = await _db.update(
      'chats',
      map,
      where: 'uid = ?',
      whereArgs: [uid],
    );

    return updated;
  }
}
