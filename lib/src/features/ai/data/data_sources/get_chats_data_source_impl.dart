import 'package:sqflite/sqflite.dart';

import '../../domain/data/data_sources/get_chats_data_source.dart';

final class GetChatsDataSourceImpl implements GetChatsDataSource {
  GetChatsDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<List<Map<String, dynamic>>> getChats({int? start, int? limit}) async {
    final maps = await _db.query('chats', orderBy: 'timestamp DESC');

    await Future.delayed(const Duration(milliseconds: 600));

    return maps;
  }
}
