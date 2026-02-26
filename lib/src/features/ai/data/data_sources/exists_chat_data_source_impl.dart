import '../../domain/data/data_sources/exists_chat_data_source.dart';
import 'package:sqflite/sqflite.dart';

final class ExistsChatDataSourceImpl implements ExistsChatDataSource {
  ExistsChatDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<bool> exists(String uid) async {
    final exists = await _db.query('chats', where: 'uid = ?', whereArgs: [uid]);

    return exists.isNotEmpty;
  }
}
