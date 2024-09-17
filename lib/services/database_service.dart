import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'inventory.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            expireDate TEXT,  // Optional field
            price REAL,
            itemNumber INTEGER,
            image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE sales (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            itemId INTEGER,
            quantity INTEGER,
            totalPrice REAL,
            date TEXT,
            FOREIGN KEY (itemId) REFERENCES items(id)
          )
        ''');

      },
    );
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert('items', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('items');
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> searchItems(String query) async {
    final db = await database;
    return await db.query(
      'items',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }

  Future<double> _getTotalSales() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(totalPrice) as totalSales FROM sales');
    return result.first['totalSales'] as double? ?? 0.0;
  }

  /*Future<double> _getProfit() async {
    // Calculate profit based on sales and item costs
  }*/


}
