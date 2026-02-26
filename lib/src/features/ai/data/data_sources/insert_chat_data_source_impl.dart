import 'package:sqflite/sqflite.dart';

import '../../domain/data/data_sources/insert_chat_data_source.dart';

final class InsertChatDataSourceImpl implements InsertChatDataSource {
  InsertChatDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<int> insert(Map<String, Object?> map) async {
    final updated = await _db.insert('chats', map);

    return updated;
  }
}
