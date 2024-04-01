import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends ChangeNotifier {
  late Database _database;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  DatabaseProvider() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'quotes_database.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
    _isInitialized = true;
    notifyListeners(); // Notify listeners after initialization
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
    await _ensureInitialized();
    return await _database.insert('quotes_data_table', row);
  }

  Future<List<Map<String, dynamic>>> getFavoriteQuotes() async {
    await _ensureInitialized();
    return await _database.query('quotes_data_table');
  }

  Future<void> deleteQuote(int id) async {
    await _ensureInitialized();
    await _database
        .delete('quotes_data_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> _ensureInitialized() async {
    if (!(_database.isOpen)) {
      await _initDatabase();
    }
  }

  Future<void> initialize() async {
    await _initDatabase();
  }
}
