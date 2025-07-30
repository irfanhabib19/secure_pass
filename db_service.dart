import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/password_model.dart';

class DBService {
  static Database? _database;
  static const String _tableName = 'passwords';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDB();
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'password_manager.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            username TEXT,
            password TEXT,
            category TEXT,
            url TEXT,
            notes TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertPassword(PasswordModel password) async {
    final db = await database;
    return await db.insert(
      _tableName,
      password.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<PasswordModel>> getPasswords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => PasswordModel.fromMap(map)).toList();
  }

  static Future<int> updatePassword(PasswordModel password) async {
    final db = await database;
    return await db.update(
      _tableName,
      password.toMap(),
      where: 'id = ?',
      whereArgs: [password.id],
    );
  }

  static Future<int> deletePassword(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
