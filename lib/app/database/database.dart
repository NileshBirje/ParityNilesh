import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_nilesh/app/models/deals_model.dart';

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
    String path = join(await getDatabasesPath(), 'deals_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE deals(
        id INTEGER PRIMARY KEY,
        comments_count INTEGER,
        created_at TEXT,
        created_at_in_millis INTEGER,
        image_medium TEXT,
        store_name TEXT
      )
    ''');
  }

  Future<int> insertDeal(DealsModel deal, int value) async {
    Database db = await database;
    return await db.insert('deals$value', deal.toJson());
  }

  Future<List<DealsModel>> getDeals(int value) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('deals$value');

    return List.generate(maps.length, (i) {
      return DealsModel(
        id: maps[i]['id'],
        commentsCount: maps[i]['comments_count'],
        createdAt: maps[i]['created_at'],
        createdAtInMillis: maps[i]['created_at_in_millis'],
        imageMedium: maps[i]['image_medium'],
        store: Store(name: maps[i]['store_name']),
      );
    });
  }
}
