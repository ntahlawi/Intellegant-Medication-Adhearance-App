import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'journal.db');
    return await openDatabase(
      path,
      version: 2, // Updated version
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE journal(id INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT, date TEXT, time TEXT, content TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute("ALTER TABLE journal ADD COLUMN userId TEXT");
        }
      },
    );
  }

  Future<void> insertEntry(Map<String, String> entry) async {
    final db = await database;
    await db.insert('journal', entry);
  }

  Future<List<Map<String, dynamic>>> getEntries(String userId) async {
    final db = await database;
    return await db.query('journal', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> deleteEntry(int id) async {
    final db = await database;
    await db.delete('journal', where: 'id = ?', whereArgs: [id]);
  }
}
