import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/data_caku.dart';
import '../model/data_category.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tableCategory = 'category';
  final String _tableCaku = 'caku';

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'keuangan_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableCategory(
            id INTEGER PRIMARY KEY,
            name TEXT,
            type TEXT
          )''',
        );
        await db.execute(
          '''CREATE TABLE $_tableCaku(
            id INTEGER PRIMARY KEY,
            amount INTEGER,
            categoryId INTEGER,
            date TEXT,
            description TEXT,
            type TEXT
          )''',
        );
      },
      version: 1,
    );
    return db;
  }

  //Helper Category
  Future<void> insertCategory(Categoryes categoryModel) async {
    final Database db = await database;
    await db.insert(_tableCategory, categoryModel.toMap());
  }

  Future<List<Categoryes>> getCategory() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableCategory);
    return results.map((e) => Categoryes.fromMap(e)).toList();
  }

  Future<Categoryes> getCategoryById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((e) => Categoryes.fromMap(e)).first;
  }

  Future<void> updateCategory(Categoryes categoryModel) async {
    final db = await database;
    await db.update(
      _tableCategory,
      categoryModel.toMap(),
      where: 'id = ?',
      whereArgs: [categoryModel.id],
    );
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete(
      _tableCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Helper Catatan Keuangan
  Future<void> insertCaku(Caku cakuModel) async {
    final Database db = await database;
    await db.insert(_tableCaku, cakuModel.toMap());
  }

  Future<List<Caku>> getCaku() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableCaku);
    return results.map((e) => Caku.fromMap(e)).toList();
  }

  Future<Caku> getCakuById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableCaku,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((e) => Caku.fromMap(e)).first;
  }

  Future<void> updateCaku(Caku cakuModel) async {
    final db = await database;
    await db.update(
      _tableCaku,
      cakuModel.toMap(),
      where: 'id = ?',
      whereArgs: [cakuModel.id],
    );
  }

  Future<void> deleteCaku(int id) async {
    final db = await database;
    await db.delete(
      _tableCaku,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
