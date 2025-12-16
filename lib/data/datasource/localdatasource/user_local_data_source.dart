import 'package:projetflutter/data/datasource/models/user.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserLocalDataSource {
  static final UserLocalDataSource _instance = UserLocalDataSource._internal();
  static Database? _database;

  factory UserLocalDataSource() {
    return _instance;
  }

  UserLocalDataSource._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        username TEXT, 
        password TEXT
      )''',
    );
  }

  Future<Map<String, dynamic>> insertUser(User user) async {
    final db = await database;
    final int userId = await db.insert('users', {
      'username': user.username,
      'password': user.password,
    });
    return {
      'id': userId,
      'username': user.username,
      'password': user.password,
    };
  }

  Future<User?> getUser(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return User(
        id: result.first['id'] as int,
        username: result.first['username'] as String,
        password: result.first['password'] as String,
      );
    }
    return null;
  }
}
