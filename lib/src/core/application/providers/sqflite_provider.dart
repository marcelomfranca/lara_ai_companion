import 'dart:developer';

import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core_app.dart';

part 'sqflite_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Database> sqflite(Ref ref) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'lara_ai_companion.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      final modules = CoreApp.modules;

      for (var module in modules) {
        if (module.sqlScript.isEmpty) continue;

        log(module.name);

        for (var sql in module.sqlScript) {
          if ((sql['version'] == version)) {
            await db.execute(sql['sql']);
          }
        }
      }
    },
  );
}
