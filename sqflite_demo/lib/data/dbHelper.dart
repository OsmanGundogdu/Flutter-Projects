import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper {
  Database? _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }
  
  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'alisveris.db');
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("create table products(id integer primary key autoincrement, name text, description text, unitPrice integer)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> delete(Product product) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id=${product.id}");
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(), where: "id=?", whereArgs: [product.id]);
    return result;
  }
}