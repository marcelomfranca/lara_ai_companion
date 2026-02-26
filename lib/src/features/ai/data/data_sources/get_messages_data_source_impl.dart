import '../../domain/data/data_sources/get_messages_data_source.dart';
import 'package:sqflite/sqflite.dart';

final class GetMessagesDataSourceImpl implements GetMessagesDataSource {
  GetMessagesDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<List<Map<String, dynamic>>> getAll(
    String uid, {
    int? start,
    int? limit,
  }) async {
    final maps = await _db.query(
      'messages',
      where: 'chat_uid = ?',
      whereArgs: [uid],
      orderBy: 'timestamp ASC',
    );

    return maps;
  }
}
