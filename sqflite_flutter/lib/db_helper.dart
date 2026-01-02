import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user.dart';

class DBHelper {
  static Database? _db;

  // Getter for database
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Raw SQL to create table
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  // Insert a user using raw SQL
  static Future<int> insertUser(User user) async {
    final db = await database;
    return await db.rawInsert(
      'INSERT INTO users(username, password) VALUES(?, ?)',
      [user.username, user.password],
    );
  }

  // Get a user by username using raw SQL
  static Future<User?> getUser(String username) async {
    final db = await database;
    final res = await db.rawQuery(
      'SELECT * FROM users WHERE username = ?',
      [username],
    );
    if (res.isNotEmpty) return User.fromMap(res.first);
    return null;
  }

  // Update user using raw SQL
  static Future<int> updateUser(User user) async {
    final db = await database;
    return await db.rawUpdate(
      'UPDATE users SET username = ?, password = ? WHERE id = ?',
      [user.username, user.password, user.id],
    );
  }

  // Delete user using raw SQL
  static Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.rawDelete(
      'DELETE FROM users WHERE id = ?',
      [id],
    );
  }
}
