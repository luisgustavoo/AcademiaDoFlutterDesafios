import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'migrations/migration_v1.dart';
import 'migrations/migration_v2.dart';

class Connection  {
  static const version = 1;
  static const databaseName = 'TODO_LIST';
  static Connection _instance;
  Database _db;
  final _lock = Lock();

  factory Connection() {
    _instance ??= Connection._();
    return _instance;
  }

  Connection._();

  Future<Database> get instance async => await _openConnection();
  void get closeConnection async => await _closeConnection();

  Future<Database> _openConnection() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          var databasePath = await getDatabasesPath();
          var pathDatabase = join(databasePath, databaseName);
          _db = await openDatabase(pathDatabase,
              version: version,
              onConfigure: _onConfigure,
              onCreate: _onCreate,
              onUpgrade: _onUpgrade);
        }
      });
    }

    return _db;
  }

  Future<void> _closeConnection() async {
    await _db?.close();
    _db = null;
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) {
    var batch = db.batch();
    createV1(batch);
    //createV2(batch);
    batch.commit();
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    var batch = db.batch();

    if (oldVersion < 2) {
      upgradeV2(batch);
    }
  }

}
