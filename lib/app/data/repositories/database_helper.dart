import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../models/qr_product_model.dart';

class DatabaseHelper {
  static const String dbName = "qr_database";
  static Database? _database;
  static const _version = 1;
  static Future<void> initDb() async {
    if (_database != null) {
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}/qr_database.db';
        _database = await openDatabase(
          path,
          version: _version,
          onCreate: _onCreate,
        );
      } catch (e) {
        Get.snackbar('wrong....', e.toString());
      }
    }
  }

  /* Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$dbName.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  } */
  static void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        qrCode TEXT,
        name TEXT,
        price TEXT,
        quantity TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertDocument(QrProductModel document) async {
    return await _database!.insert(dbName, document.toMap());
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    return await _database!.query(dbName);
  }

  Future delete(int id) async {
    return await _database!.delete(dbName, where: 'id=?', whereArgs: [id]);
  }
}
/* class ToDoDbHelper {
  static Database? _db;
  static const _version = 1;
  static const String _tabelname = 'tasks';
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()} + tasks.db';
        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) {
            print('open todo');
            return db.execute(
              "CREATE TABLE $_tabelname ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT, todo TEXT,date STRING,"
              "remind TEXT,repeat TEXT,"
              "color INTEGER,"
              "isCompleted INTEGER NOT NULL )",
            );
          },
        );
      } catch (e) {
        Get.snackbar('wrong....', e.toString());
      }
    }
  }
  static void updateTodo(TodoModel todo) async {
    await _db!.update(_tabelname, todo.toMap(),
        where: 'id=?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tabelname);
  }
  static delete(String id) async {
    return await _db!.delete(_tabelname, where: 'id=?', whereArgs: [id]);
  }
  static updateComplete(int id) async {
    return await _db!.rawUpdate(
        '''UPDATE tasks SET isCompleted = ?, WHERE id = ?,''', [1, id]);
  }
} */
