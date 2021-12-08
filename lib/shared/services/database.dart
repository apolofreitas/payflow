import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static Database get db => _db!;

  static Future<void> initialize() async {
    if (_db != null) return;

    _db = await openDatabase(
      path.join(await getDatabasesPath(), 'payflow_database.db'),
      onCreate: (db, version) {
        return db.execute(
            """
            CREATE TABLE boletos(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              value REAL,
              dueDate TEXT,
              barcode TEXT,
              wasPaid INTEGER
            )
      """);
      },
      version: 1,
    );
  }
}
