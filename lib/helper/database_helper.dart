import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      return await _initDatabase();
    }
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'quotes_database.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
    return _database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quotes_data_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quotes TEXT,
        category TEXT,
        author TEXT,
        time TEXT
      )
    ''');
    print("Database created........");
  }

  Future<int> insertQuote(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('quotes_data_table', row);
  }

  Future<List<Map<String, dynamic>>> getFavoriteQuotes() async {
    final db = await database;
    return await db.query('quotes_data_table');
  }

  Future<void> deleteQuote(int id) async {
    final db = await database;
    await db.delete('quotes_data_table', where: 'id = ?', whereArgs: [id]);
  }
}

// // lib/helper/database_helper.dart
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static late Database _database;
//
//   DatabaseHelper._();
//
//   static final DatabaseHelper instance = DatabaseHelper._();
//
//   Future<Database> get database async {
//     if (_database.isOpen) {
//       return _database;
//     } else {
//       return await _initDatabase();
//     }
//   }
//
//   Future<Database> _initDatabase() async {
//     final path = await getDatabasesPath();
//     final databasePath = join(path, 'quotes_database.db');
//     _database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: _createDatabase,
//     );
//     return _database;
//   }
//
//   Future<void> _createDatabase(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE quotes_data_table(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         quotes TEXT,
//         category TEXT,
//         author TEXT,
//         time TEXT
//       )
//     ''');
//     print("Database created........");
//   }
//
//   Future<int> insertQuote(Map<String, dynamic> row) async {
//     final db = await database;
//     return await db.insert('quotes_data_table', row);
//   }
//
//   Future<List<Map<String, dynamic>>> getFavoriteQuotes() async {
//     final db = await database;
//     return await db.query('quotes_data_table');
//   }
//
//   Future<void> deleteQuote(int id) async {
//     final db = await database;
//     await db.delete('quotes_data_table', where: 'id = ?', whereArgs: [id]);
//   }
// }
