import '../../domain/data/data_sources/save_message_data_source.dart';
import 'package:sqflite/sqflite.dart';

final class SaveMessageDataSourceImpl implements SaveMessageDataSource {
  SaveMessageDataSourceImpl(this._db);

  final Database _db;

  @override
  Future<int> save(Map<String, Object?> map) async {
    return await _db.insert('messages', map);
  }
}
